<h1>{lang}Language_Manager{/lang}</h1>
<div class="draggable">
	<form method="post">
		<table class="ntable" cellpadding="4" cellspacing="0">
			<thead>
				<tr>
					<th colspan="2">{lang}ADD_NEW_LANGUAGE{/lang}</th>
				</tr>
			</thead>
			<tr>
				<td><label for="f_langcode">{lang}Language_Code{/lang}</label></td>
				<td><input type="text" name="langcode" id="f_langcode" maxlength="3" /></td>
			</tr>
			<tr>
				<td><label for="f_language">{lang}Language{/lang}</label></td>
				<td><input type="text" name="language" id="f_language" maxlength="128" /></td>
			</tr>
			<tr>
				<td><label for="f_charset">{lang}Charset{/lang}</label></td>
				<td><input type="text" name="charset" id="f_charset" maxlength="128" /></td>
			</tr>
			<tfoot>
				<tr>
					<td colspan="2"><input type="submit" name="add_language" value="{lang}Commit{/lang}" class="button" /></td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div id="right"><div class="link_b">{link[Back]}"language"{/link}</div></div>