<table class="ntable">
	<tr>
		<th colspan="2">{lang}ALLIANCES{/lang}</th>
	</tr>
	<tr>
		<td>{@foundAlly}</td>
		<td>{@joinAlly}</td>
	</tr>
</table>
{if[count($this->loopStack["applications"]) > 0]}<form method="post" action="{@formaction}">
<input type="hidden" name="alliance[]" value="0" />
<table class="ntable">
	<tr>
		<th colspan="4">{lang}RUNNING_APPLICATIONS{/lang}</th>
	</tr>
	<tr>
		<th>{lang}ALLIANCE{/lang}</th>
		<th>{lang}APPLICATION{/lang}</th>
		<th></th>
		<th></th>
	</tr>
	{foreach[applications]}<tr>
		<td class="center">{loop}tag{/loop}</td>
		<td>{loop}apptext{/loop}</td>
		<td class="center">{loop}date{/loop}</td>
		<td class="center"><input type="checkbox" name="alliance[]" value="{loop}aid{/loop}" /></td>
	</tr>{/foreach}
	<tr>
		<td colspan="4" class="center">{lang}MARKED{/lang} <input type="submit" name="cancel" value="{lang}CANCEL{/lang}" class="button" /></td>
	</tr>
</table>{/if}
</form>