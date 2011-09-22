<?php
/**
 * Shipyard page. Shows ships and defense and allows to construct them.
 *
 * @package Bengine
 * @copyright Copyright protected by / Urheberrechtlich geschützt durch "Sebastian Noll" <snoll@4ym.org>
 * @version $Id: Shipyard.php 19 2011-05-27 10:30:33Z secretchampion $
 */

class Bengine_Page_Shipyard extends Bengine_Page_Construction_Abstract
{
	/**
	 * Shipyard display mode.
	 * 3: Fleet, 4: Defense
	 *
	 * @var integer
	 */
	protected $mode = 0;

	/**
	 * If units can be build.
	 *
	 * @var boolean
	 */
	protected $canBuildUnits = false;

	/**
	 * If rockets can be build.
	 *
	 * @var boolean
	 */
	protected $canBuildRockets = true;

	/**
	 * Number of existing rockets
	 * (Even working).
	 *
	 * @var integer
	 */
	protected $existingRockets = 0;

	/**
	 * Constructor: Shows unit selection.
	 *
	 * @return Bengine_Page_Shipyard
	 */
	protected function init()
	{
		$this->canBuildUnits = Bengine::getEH()->canBuildUnits();

		switch(Core::getRequest()->getGET("controller"))
		{
			case "Shipyard": $this->mode = 3; break;
			case "Defense": $this->mode = 4; break;
		}

		if(Bengine::getPlanet()->getBuilding("ROCKET_STATION") > 0 && $this->mode == 4)
		{
			$_result = Core::getQuery()->select("unit2shipyard", "quantity", "", "unitid = '51' AND planetid = '".Core::getUser()->get("curplanet")."'");
			$_row = Core::getDB()->fetch($_result);
			$this->existingRockets = $_row["quantity"];
			$_result = Core::getQuery()->select("unit2shipyard", "quantity", "", "unitid = '52' AND planetid = '".Core::getUser()->get("curplanet")."'");
			$_row = Core::getDB()->fetch($_result);
			$this->existingRockets += $_row["quantity"] * 2;
			$this->existingRockets += Bengine::getEH()->getWorkingRockets();

			$maxsize = Bengine::getRocketStationSize();

			// Check max. size
			if($this->existingRockets >= $maxsize)
			{
				$this->canBuildRockets = false;
			}
		}

		return parent::init();
	}

	/**
	 * Index action.
	 *
	 * @return Bengine_Page_Shipyard
	 */
	protected function indexAction()
	{
		Core::getLanguage()->load(array("info", "buildings"));
		$this->setTemplate("shipyard_index");

		$collection = Application::getCollection("construction", "unit");
		$collection->addTypeFilter($this->mode)
			->addShipyardJoin(Core::getUser()->get("curplanet"));

		if(Bengine::getPlanet()->getBuilding("SHIPYARD") == 0)
		{
			Logger::dieMessage("SHIPYARD_REQUIRED");
		}
		if($this->mode == 3)
			Core::getTPL()->assign("shipyard", Core::getLanguage()->getItem("SHIP_CONSTRUCTION"));
		else
			Core::getTPL()->assign("shipyard", Core::getLanguage()->getItem("DEFENSE"));

		// Output shipyard missions
		Core::getQuery()->delete("shipyard", "finished <= '".TIME."'");
		$missions = array();
		$result = Core::getQuery()->select("shipyard s", array("s.quantity", "s.one", "s.time", "s.finished", "b.name"), "LEFT JOIN ".PREFIX."construction b ON (b.buildingid = s.unitid)", "s.planetid = '".Core::getUser()->get("curplanet")."' ORDER BY s.time ASC");
		if($row = Core::getDB()->fetch($result))
		{
			Core::getTPL()->assign("hasEvent", true);
			Core::getTPL()->assign("currentWork", Core::getLanguage()->getItem($row["name"]));
			$x = TIME - $row["time"];
			$lefttime = $row["one"] - ($x - floor($x / $row["one"]) * $row["one"]);
			Core::getTPL()->assign("remainingTime", getTimeTerm($lefttime));

			Core::getDB()->reset_resource($result);
			while($row = Core::getDB()->fetch($result))
			{
				$quantity = ($row["time"] < TIME) ? ceil(($row["finished"] - TIME) / $row["one"]) : $row["quantity"];
				$missions[] = array(
					"quantity" => $quantity,
					"mission" => Core::getLanguage()->getItem($row["name"])
				);
			}
			Core::getDB()->free_result($result);
		}
		else
		{
			Core::getDB()->free_result($result);
			Core::getTPL()->assign("hasEvent", false);
		}

		Core::getTPL()->addLoop("events", $missions);
		Core::getTPL()->addLoop("units", $collection);
		Core::getTPL()->assign("canBuildUnits", $this->canBuildUnits);
		Core::getTPL()->assign("canBuildRockets", $this->canBuildRockets);
		$this->assign("orderAction", BASE_URL."game.php/".SID."/".$this->getParam("controller")."/Order");
		return $this;
	}

	/**
	 * Starts an event for building units.
	 *
	 * @return Bengine_Page_Shipyard
	 */
	protected function orderAction()
	{
		if(Core::getUser()->get("umode") || Bengine::isDbLocked())
		{
			$this->redirect("game.php/".SID."/".Core::getRequest()->getGET("controller"));
		}
		$post = Core::getRequest()->getPOST();
		$result = Core::getQuery()->select("construction", array("buildingid", "name", "basic_metal", "basic_silicon", "basic_hydrogen", "basic_energy"), "", "mode = '".$this->mode."'", "display_order ASC, buildingid ASC");
		while($row = Core::getDB()->fetch($result))
		{
			$id = $row["buildingid"];
			if(isset($post[$id]) && $post[$id] > 0)
			{
				// Vacation enabled?
				if(Core::getUser()->get("umode"))
					throw new Recipe_Exception_Generic("Your account is still in vacation mode.");

				// Check for requirements
				if(!Bengine::canBuild($id))
					throw new Recipe_Exception_Generic("You cannot build this.");

				if(!$this->canBuildUnits)
					throw new Recipe_Exception_Generic("Shipyard or nano factory in progress.");

				$quantity = _pos($post[$id]);
				if($quantity > 1000)
					$quantity = 1000;

				Hook::event("UnitOrderStart", array(&$row, &$quantity));

				if($id == 49 || $id == 50)
				{
					$_result = Core::getQuery()->select("unit2shipyard", "quantity", "", "unitid = '".$id."' AND planetid = '".Core::getUser()->get("curplanet")."'");
					if(Core::getDB()->num_rows($_result) > 0)
					{
						throw new Recipe_Exception_Generic("You cannot build this.");
					}
					Core::getDB()->free_result($_result);
					if(Bengine::getEH()->hasSShieldDome() && $id == 49)
					{
						throw new Recipe_Exception_Generic("You cannot build this.");
					}
					if(Bengine::getEH()->hasLShieldDome() && $id == 50)
					{
						throw new Recipe_Exception_Generic("You cannot build this.");
					}
					$quantity = 1; // Make sure that shields cannot be build twice
				}
				if($id == 51 || $id == 52)
				{
					$maxsize = Bengine::getRocketStationSize();

					// Check max. size
					if(!$this->canBuildRockets)
					{
						continue;
					}

					// Decrease quantity, if necessary
					if($id == 52) { $quantity *= 2; }
					if($quantity > $maxsize - $this->existingRockets)
					{
						$quantity = $maxsize - $this->existingRockets;
					}
					if($id == 52) { $quantity = floor($quantity / 2); }
				}

				// Check resources
				$quantity = $this->checkResourceForQuantity($quantity, $row);

				// make event
				if($quantity > 0)
				{
					$latest = TIME;
					$_result = Core::getQuery()->select("events", array("MAX(time) as latest"), "", "planetid = '".Core::getUser()->get("curplanet")."' AND (mode = '4' OR mode = '5') LIMIT 1");
					$_row = Core::getDB()->fetch($_result);
					Core::getDB()->free_result($_result);
					if($_row["latest"] >= TIME)
					{
						$latest = $_row["latest"];
					}
					unset($_result); unset($_row);

					$time = getBuildTime($row["basic_metal"], $row["basic_silicon"], $this->mode);

					// This is just for the output below the shipyard, it does not represent the actual event!
					Core::getQuery()->insert("shipyard", array("planetid", "unitid", "quantity", "one", "time", "finished"), array(Core::getUser()->get("curplanet"), $id, $quantity, $time, $latest, $time * $quantity + $latest));

					$data["time"] = $time;
					$data["quantity"] = $quantity;
					$data["mission"] = $row["name"];
					$data["buildingid"] = $id;
					$data["metal"] = $row["basic_metal"];
					$data["silicon"] = $row["basic_silicon"];
					$data["hydrogen"] = $row["basic_hydrogen"];
					$data["points"] = ($row["basic_metal"] + $row["basic_silicon"] + $row["basic_hydrogen"]) / 1000;
					$data["dont_save_resources"] = true; // We save the subtracted resources manually to avoid unnecessary SQL queries.
					if($this->mode == 3) { $mode = 4; } else { $mode = 5; }
					Hook::event("UnitOrderLast", array($row, $quantity, $mode, &$time, &$latest, &$data));
					for($i = 1; $i <= $quantity; $i++)
					{
						Bengine::getEH()->addEvent($mode, $time * $i + $latest, Core::getUser()->get("curplanet"), Core::getUser()->get("userid"), null, $data);
					}
					$planet = Bengine::getPlanet();
					Core::getQuery()->update("planet", array("metal", "silicon", "hydrogen"), array($planet->getData("metal"), $planet->getData("silicon"), $planet->getData("hydrogen")), "planetid = '".Core::getUser()->get("curplanet")."'");
				}
			}
		}
		Core::getDB()->free_result($result);
		$this->redirect("game.php/".SID."/".Core::getRequest()->getGET("controller"));
		return $this;
	}

	/**
	 * Checks the resource against the given quantity and reduce it if needed.
	 *
	 * @param integer	Quantity
	 * @param array		Ship data row
	 *
	 * @return integer
	 */
	protected function checkResourceForQuantity($qty, array $row)
	{
		$metal = _pos(Bengine::getPlanet()->getData("metal"));
		$silicon = _pos(Bengine::getPlanet()->getData("silicon"));
		$hydrogen = _pos(Bengine::getPlanet()->getData("hydrogen"));
		$energy = _pos(Bengine::getPlanet()->getEnergy());

		$requiredMetal = $row["basic_metal"] * $qty;
		$requiredSilicon = $row["basic_silicon"] * $qty;
		$requiredHydrogen = $row["basic_hydrogen"] * $qty;
		$requiredEnergy = $row["basic_energy"] * $qty;
		if($requiredMetal > $metal || $requiredSilicon > $silicon || $requiredHydrogen > $hydrogen || $requiredEnergy > $energy)
		{
			// Try to reduce quantity
			$q = array();
			$q[] = ($row["basic_metal"] > 0) ? floor($metal / $row["basic_metal"]) : $qty;
			$q[] = ($row["basic_silicon"] > 0) ? floor($silicon / $row["basic_silicon"]) : $qty;
			$q[] = ($row["basic_hydrogen"] > 0) ? floor($hydrogen / $row["basic_hydrogen"]) : $qty;
			$q[] = ($row["basic_energy"] > 0) ? floor($energy / $row["basic_energy"]) : $qty;
			$qty = min($q);
		}

		return $qty;
	}

	/**
	 * Scrap merchant.
	 *
	 * @return Bengine_Page_Shipyard
	 */
	protected function merchantAction()
	{
		if(!Core::getConfig()->get("SCRAP_MERCHANT_RATE"))
		{
			$this->redirect("game.php/".SID."/Shipyard");
		}
		Core::getLanguage()->load(array("info", "buildings"));
		$this->setTemplate("shipyard_merchant");
		$units = Application::getCollection("fleet", "unit");
		$units->addPlanetFilter(Core::getUser()->get("curplanet"));
		$this->assign("units", $units);
		Core::getLang()->assign("merchantRate", Core::getConfig()->get("SCRAP_MERCHANT_RATE")*100);
		return $this;
	}

	/**
	 * Changes the ships against resources.
	 *
	 * @return Bengine_Page_Shipyard
	 */
	protected function changeAction()
	{
		if(!Core::getConfig()->get("SCRAP_MERCHANT_RATE"))
		{
			$this->redirect("game.php/".SID."/Shipyard");
		}
		if(Core::getRequest()->getPOST("verify") == "no")
		{
			$this->redirect("game.php/".SID."/Shipyard/Merchant");
		}
		Core::getLanguage()->load(array("info", "buildings"));
		$selUnits = Core::getRequest()->getPOST("unit");
		$availUnits = Application::getCollection("fleet", "unit");
		$availUnits->addPlanetFilter(Core::getUser()->get("curplanet"));
		$metalCredit = 0;
		$siliconCredit = 0;
		$hydrogenCredit = 0;
		$totalQty = 0;
		$realUnits = array();
		$rate = (double) Core::getConfig()->get("SCRAP_MERCHANT_RATE");
		foreach($availUnits as $unit)
		{
			$unitId = $unit->getUnitid();
			if(isset($selUnits[$unitId]) && $selUnits[$unitId] > 0)
			{
				$qty = _pos((int) $selUnits[$unitId]);
				$qty = min($qty, $unit->getQty());
				$metalCredit += $qty*$unit->get("basic_metal");
				$siliconCredit += $qty*$unit->get("basic_silicon");
				$hydrogenCredit += $qty*$unit->get("basic_hydrogen");
				$totalQty += $qty;
				$realUnits[(int) $unitId] = $qty;
			}
		}
		$points = ($metalCredit + $siliconCredit + $hydrogenCredit) / 1000;
		$metalCredit = floor($metalCredit*$rate);
		$siliconCredit = floor($siliconCredit*$rate);
		$hydrogenCredit = floor($hydrogenCredit*$rate);
		Core::getLang()->assign(array(
			"metalCredit" => fNumber($metalCredit),
			"siliconCredit" => fNumber($siliconCredit),
			"hydrogenCredit" => fNumber($hydrogenCredit),
			"totalQty" => fNumber($totalQty),
		));
		if(Core::getRequest()->getPOST("verify") == "yes")
		{
			foreach($availUnits as $unit)
			{
				$unitId = (int) $unit->getUnitid();
				if(isset($realUnits[$unitId]))
				{
					$qty = $realUnits[$unitId];
					if($unit->getQty() <= $qty)
					{
						Core::getQuery()->delete("unit2shipyard", "`unitid` = '{$unitId}' AND `planetid` = '".Core::getUser()->get("curplanet")."'");
					}
					else
					{
						$sql = "UPDATE `".PREFIX."unit2shipyard` SET `quantity` = `quantity` - '{$qty}' WHERE `unitid` = '{$unitId}' AND `planetid` = '".Core::getUser()->get("curplanet")."'";
						Core::getDatabase()->query($sql);
					}
				}
			}
			$sql = "UPDATE `".PREFIX."planet` SET `metal` = `metal` + '{$metalCredit}', `silicon` = `silicon` + '{$siliconCredit}', `hydrogen` = `hydrogen` + '{$hydrogenCredit}' WHERE `planetid` = '".Core::getUser()->get("curplanet")."'";
			Core::getDatabase()->query($sql);
			$sql = "UPDATE `".PREFIX."user` SET `points` = `points` - '{$points}' WHERE `userid` = '".Core::getUser()->get("userid")."'";
			Core::getDatabase()->query($sql);
			$this->redirect("game.php/".SID."/Shipyard");
		}
		$this->setTemplate("shipyard_change");
		$this->assign("units", $realUnits);
		return $this;
	}
}
?>