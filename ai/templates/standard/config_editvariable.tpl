<h1>{lang}Cronjobs{/lang}</h1>
<div class="draggable">
<form method="post">
<input type="hidden" name="groupid" value="{@groupid}" />
<input type="hidden" name="var" value="{@var}" />
<table class="ntable" cellpadding="4" cellspacing="0">
	<thead>
		<tr>
			<th colspan="2">{lang}Edit_Configuration_Variable{/lang}</th>
		</tr>
	</thead>
	<tr>
		<td>{lang=Variable}</td>
		<td>{@var}</td>
	</tr>
	<tr>
		<td><label for="f_group">{lang}Variable_Group{/lang}</label></td>
		<td><select name="groupid" id="f_group">{@groups}</select></td>
	</tr>
	<tr>
		<td><label for="f_type">{lang=Variable_Type}</label></td>
		<td><select name="type" id="f_type">{@type}</select></td>
	</tr>
	<tr id="options">
		<td><label for="f_options">{lang=Options}</label></td>
		<td><textarea name="options" id="f_options" rows="5" cols="50">{@options}</textarea><br />{lang=Comma_Separated}</td>
	</tr>
	<tr>
		<td><label for="f_desc">{lang=Description}</label></td>
		<td><textarea name="description" id="f_desc" rows="5" cols="50">{@description}</textarea></td>
	</tr>
	<tr>
		<td colspan="2" class="center"><input type="submit" name="save_var" value="{lang}Commit{/lang}" class="button" /></td>
	</tr>
</table>
</form>
</div>
<script type="text/javascript">
//<![CDATA[
function showOptions()
{
	if($('#f_type').val() == 'enum' || $('#f_type').val() == 'select')
	{
		return true;
	}
	return false;
}

$(document).ready(function() {
	if(!showOptions())
	{
		$('#options').hide();
	}
});
$('#f_type').change(function() {
	if(showOptions())
	{
		$('#options').fadeIn(500);
	}
	else
	{
		$('#options').fadeOut(500);
	}
});
//]]>
</script>
<div id="right"><div class="link_b">{link[Back]}"config/showVariables/".Core::getRequest()->getGET("1"){/link}</div></div>