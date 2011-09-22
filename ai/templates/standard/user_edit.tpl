<h1>{lang}User_Manager{/lang}</h1>
<div class="draggable">
	<form method="post">
		<input type="hidden" name="userid" value="{request[get]}1{/request}" />
		<table class="ntable" cellpadding="4" cellspacing="0">
			<thead>
				<tr>
					<th colspan="2">{lang}Edit_User{/lang}</th>
				</tr>
			</thead>
			<tr>
				<td><label for="f_username">{lang}Username{/lang}</label></td>
				<td><input type="text" name="username" maxlength="128" id="f_username" value="{@username}" /></td>
			</tr>
			<tr>
				<td><label for="f_password">{lang}Password{/lang}</label></td>
				<td><input type="text" name="password" maxlength="128" id="f_password" /></td>
			</tr>
			<tr>
				<td><label for="f_email">{lang}E_Mail{/lang}</label></td>
				<td><input type="text" name="email" maxlength="128" id="f_email" value="{@email}" /></td>
			</tr>
			<tr>
				<td><label for="f_language">{lang}Language{/lang}</label></td>
				<td><select name="languageid" id="f_language">{while[langs]}<option value="{loop}languageid{/loop}"{if[$row["languageid"] == $this->templateVars["languageid"]]} selected="selected"{/if}>{loop}title{/loop}</option>{/while}</select></td>
			</tr>
			<tr>
				<td><label for="f_template">{lang}Template_Package{/lang}</label></td>
				<td><select name="templatepackage" id="f_template">{@templates}</select></td>
			</tr>
			<tr>
				<td><label for="f_ipcheck">{lang}IP_Check{/lang}</label></td>
				<td><select name="ipcheck" id="f_ipcheck"><option value="1"{if[$this->templateVars["ipcheck"]]} selected="selected"{/if}>{lang}Yes{/lang}</option><option value="0"{if[!$this->templateVars["ipcheck"]]} selected="selected"{/if}>{lang}No{/lang}</option></select></td>
			</tr>
			<tfoot>
				<tr>
					<td colspan="2"><input type="submit" name="save_user" value="{lang}Commit{/lang}" class="button" /></td>
				</tr>
				<tr>
					<td colspan="2"><select name="usergroup" id="f_usergroup">{while[groups]}<option value="{loop}usergroupid{/loop}">{loop}grouptitle{/loop}</option>{/while}</select> <input type="text" name="data" maxlength="255" id="f_data" /> <input type="submit" name="add_usermembership" value="{lang}Add_To_User_Group{/lang}" class="button" /></td>
				</tr>
				{if[count($this->loopStack["membership"]) > 0]}<tr>
					<td colspan="2"><strong>{lang}Membership{/lang}</strong><br />{foreach[membership]}<span class="ug">{loop}grouptitle{/loop} [{loop}delete{/loop}]</span>{/foreach}</td>
				</tr>{/if}
			</tfoot>
		</table>
	</form>
</div>
<div id="right"><div class="link_b">{link[Back]}"user/seek"{/link}</div></div>