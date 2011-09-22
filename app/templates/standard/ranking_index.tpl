<form method="post" action="{@formaction}">
<table class="ntable">
	<tr>
		<th>{lang}MENU_RANKING{/lang}</th>
	</tr>
	<tr>
		<td class="center">
			<label for="mode">{lang}MODE{/lang}</label> <select name="mode" id="mode"><option value="1"{@mod1Sel}>{lang}PLAYER{/lang}</option><option value="2"{@mod2Sel}>{lang}ALLIANCE{/lang}</option></select>&nbsp;
			<label for="type">{lang}TYPE{/lang}</label> <select name="type" id="type"><option value="points"{@type1Sel}>{lang}POINTS{/lang}</option><option value="fpoints"{@type2Sel}>{lang}FLEET{/lang}</option><option value="rpoints"{@type3Sel}>{lang}RESEARCH{/lang}</option></select>&nbsp;
			<label for="pos">{lang}RANK{/lang}</label> <select name="pos" id="pos">{@rankingSel}</select>&nbsp;
			<input type="checkbox" name="avg" id="avg" value="1"{if[$this->templateVars["avg_on"]]} checked="checked"{/if} /><label for="avg">{lang}AVERAGE{/lang}</label>&nbsp;
			<input type="submit" name="go" value="{lang}COMMIT{/lang}" class="button" />
		</td>
	</tr>
</table>
</form>