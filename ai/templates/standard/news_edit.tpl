<h1>{lang}News{/lang}</h1>
<div class="draggable">
	<form method="post">
	{if[{var=languageCount} == 1]}
	<input type="hidden" name="language_id" value="{@languages}"/>
	{/if}
		<table class="ntable" cellpadding="4" cellspacing="0">
			<thead>
				<tr>
					<th colspan="2">{lang}Edit_News{/lang}</th>
				</tr>
			</thead>
			<tr>
				<td><label for="f_title">{lang}Title{/lang}</label></td>
				<td><input type="text" name="title" id="f_title" value="{@title}"/></td>
			</tr>
			<tr>
				<td><label for="f_text">{lang}Text{/lang}</label></td>
				<td><textarea cols="75" rows="15" name="text" id="f_text">{@text}</textarea></td>
			</tr>
			{if[{var=languageCount} > 1]}
			<tr>
				<td><label for="f_language">{lang}Language{/lang}</label></td>
				<td>
					<select name="language_id" id="f_language">
						{@languages}
					</select>
				</td>
			</tr>
			{/if}
			<tfoot>
				<tr>
					<td colspan="2"><input type="submit" name="save" value="{lang}Commit{/lang}" class="button"/></td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div id="right"><div class="link_b">{link[Back]}"news"{/link}</div></div>