<h1>{lang}Configuration{/lang}</h1>
<div class="draggable">
<form method="post" action="{@faction}">
<table class="ntable" cellpadding="4" cellspacing="0">
	<tr>
		<th colspan="2">{lang}Add_Config_Var{/lang}</th>
	</tr>
	<tr>
		<td><label for="f_group">{lang}Variable_Group{/lang}</label></td>
		<td><select name="groupid" id="f_group">{foreach[groups]}<option value="{loop}groupid{/loop}">{loop}title{/loop}</option>{/foreach}</select></td>
	</tr>
	<tr>
		<td><label for="f_var">{lang}Variable{/lang}</label></td>
		<td><input type="text" name="var" maxlength="128" id="f_var" /></td>
	</tr>
	<tr>
		<td><label for="f_type">{lang}Variable_Type{/lang}</label></td>
		<td><select name="type" id="f_type">{@varTypes}</select></td>
	</tr>
	<tr id="options">
		<td><label for="f_options">{lang=Options}</label></td>
		<td><textarea name="options" id="f_options" rows="5" cols="50"></textarea><br />{lang=Comma_Separated}</td>
	</tr>
	<tr>
		<td><label for="f_value">{lang}Value{/lang}</label></td>
		<td><textarea cols="50" rows="5" name="value" id="f_value"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;"><input type="submit" name="add_var" value="{lang}Commit{/lang}" class="button" /></td>
	</tr>
</table>
</form>
</div>
<div class="draggable">
<form method="post" action="{@faction}">
<input type="hidden" name="delete[]" value="0" />
<table class="ntable" cellpadding="4" cellspacing="0">
	<tr>
		<th colspan="3">{lang}Manage_Groups{/lang}</th>
	</tr>
	<tr>
		<td>{lang}Variable_Group{/lang}</td>
		<td></td>
		<td>{lang}Delete{/lang}</td>
	</tr>
	{foreach[groups]}<tr>
		<td><input type="hidden" name="groups[]" value="{loop}groupid{/loop}" /><input type="text" name="title_{loop}groupid{/loop}" value="{loop}title{/loop}" maxlength="128" /></td>
		<td>{loop}showvars{/loop}</td>
		<td><input type="checkbox" name="delete[]" value="{loop}groupid{/loop}" /></td>
	</tr>{/foreach}
	<tr>
		<td colspan="3" style="text-align: center;">
			{link[Add_Variable_Group]}"config/addGroup"{/link}<br />
			<input type="submit" name="save_groups" value="{lang}Commit{/lang}" class="button" />
		</td>
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