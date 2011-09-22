<?php $numLanguages = Core::getDatabase()->num_rows($this->getLoop("langs")) ?>
<form method="post" action="{@formaction}">
<table class="ntable">
	<tr>
		<th colspan="2">{lang}MODERATE_USER{/lang}</th>
	</tr>
	<tr>
		<th colspan="2">{lang}USER_DATA{/lang}<input type="hidden" name="userid" value="{@userid}" /></th>
	</tr>
	<tr>
		<td><label for="username">{lang}USERNAME{/lang}</label></td>
		<td><input type="text" name="username" id="username" value="{@username}" maxlength="{config}MAX_USER_CHARS{/config}" /></td>
	</tr>
	<tr>
		<td><label for="usertitle">{lang}USER_TITLE{/lang}</label></td>
		<td><input type="text" name="usertitle" id="usertitle" value="{@usertitle}" maxlength="{config}MAX_USER_CHARS{/config}" /></td>
	</tr>
	<tr>
		<td><label for="email">{lang}EMAIL{/lang}</label></td>
		<td><input type="text" name="email" id="email" value="{@email}" maxlength="{config}MAX_INPUT_LENGTH{/config}" /></td>
	</tr>
	<tr>
		<td><label for="temp-email">{lang}TEMP_EMAIL{/lang}</label></td>
		<td><a href="mailto:{@temp_email}" id="temp-email">{@temp_email}</a></td>
	</tr>
	<tr>
		<td><label for="pw">{lang}NEW_PASSWORD{/lang}</label></td>
		<td><input type="text" name="password" id="pw" maxlength="{config}MAX_PASSWORD_LENGTH{/config}" /></td>
	</tr>
	<tr>
		<td><label>{lang}LAST_ACTIVITY{/lang}</label></td>
		<td>{@last}</td>
	</tr>
	<tr>
		<td><label>{lang}REGISTRATION_DATE{/lang}</label></td>
		<td>{@regtime}</td>
	</tr>
	{if[{var}tag{/var} != ""]}<tr>
		<td><label>{lang}ALLIANCE{/lang}</label></td>
		<td><strong>{@tag}</strong></td>
	</tr>{/if}
	{perm[CAN_EDIT_USER]}<tr>
		<td><label for="points">{lang}POINTS{/lang}</label></td>
		<td><input type="text" name="points" id="points" value="{@points}" maxlength="{config}MAX_USER_CHARS{/config}" /></td>
	</tr>
	<tr>
		<td><label for="fpoints">{lang}FLEET{/lang}</label></td>
		<td><input type="text" name="fpoints" id="fpoints" value="{@fpoints}" maxlength="{config}MAX_USER_CHARS{/config}" /></td>
	</tr>
	<tr>
		<td><label for="rpoints">{lang}RESEARCH{/lang}</label></td>
		<td><input type="text" name="rpoints" id="rpoints" value="{@rpoints}" maxlength="{config}MAX_USER_CHARS{/config}" /></td>
	</tr>{/perm}
	<tr>
		<th colspan="2">{lang}ADVANCED_PREFERENCES{/lang}</th>
	</tr>
	<?php if($numLanguages > 1): ?>
	<tr>
		<td><label for="langauage">{lang}LANGUAGE{/lang}</label></td>
		<td><select name="langauageid" id="langauage">{while[langs]}<option value="{loop}languageid{/loop}"{if[{var}languageid{/var} == $row["languageid"]]} selected="selected"{/if}>{loop}title{/loop}</option>{/while}</select></td>
	</tr>
	<?php endif ?>
	{perm[CAN_EDIT_USER]}<tr>
		<td><label for="usergroup">{lang}USER_GROUP{/lang}</label></td>
		<td><select name="usergroupid" id="usergroup"><option value="3">User</option><option value="2"{if[{var}isAdmin{/var}]} selected="selected"{/if}>Administrator</option><option value="4"{if[{var}isMod{/var}]}selected="selected"{/if}>Moderator</option></select></td>
	</tr>{/perm}
	<tr>
		<td><label for="del-acc">{lang}DELETE_ACCOUNT{/lang}</label></td>
		<td><input type="checkbox" name="delete" id="del-acc" value="1"{if[{var}deletion{/var} > 0]} checked="checked"{/if} />{if[{var}deletion{/var} > 0]}<span class="notavailable">{@delmessage}</span>{/if}</td>
	</tr>
	<tr>
		<td><label for="ip-check">{lang}IP_CHECK_ACTIVATED{/lang}</label></td>
		<td><input type="checkbox" name="ipcheck" id="ip-check" value="1"{if[{var}ipcheck{/var}]} checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td><label for="activation">{lang}ACTIVATED{/lang}</label></td>
		<td><input type="checkbox" name="activation" id="activation" value="1"{if[{var}activation{/var} == ""]} checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td><label for="umode">{lang}VACATION_MODE{/lang}</label></td>
		<td><input type="checkbox" name="umode" id="umode" value="1"{if[{var}vacation{/var}]} checked="checked"{/if} /></td>
	</tr>
	<tr>
		<th colspan="2">{lang}CUSTOM_LOOK{/lang}</th>
	</tr>
	<tr>
		<td><label for="templatepackage">{lang}TEMPLATE_PACKAGE{/lang}</label></td>
		<td><input type="text" name="templatepackage" id="templatepackage" maxlength="{config}MAX_INPUT_LENGTH{/config}" value="{@templatepackage}"/></td>
	</tr>
	<tr>
		<td><label for="theme">{lang}THEME{/lang}</label></td>
		<td><input type="text" name="theme" id="theme" maxlength="{config}MAX_INPUT_LENGTH{/config}" value="{@theme}"/></td>
	</tr>
	<tr>
		<td><label for="js_interface">{lang}JS_INTERFACE{/lang}</label></td>
		<td><input type="text" name="js_interface" id="js_interface" maxlength="{config}MAX_INPUT_LENGTH{/config}" value="{@js_interface}"/></td>
	</tr>
	<tr>
		<td class="center" colspan="2">
			<?php if($numLanguages == 1): ?>
			<input type="hidden" name="languageid" value="{config=defaultlanguage}"/>
			<?php endif ?>
			<input type="submit" name="proceed" value="{lang}PROCEED{/lang}" class="button"/><br/>
			{@loginLink} | {@sessionsLink}
		</td>
	</tr>
	<tr>
		<th colspan="2">{lang}BAN_USER{/lang}</th>
	</tr>
	<tr>
		<td><label for="ban-for">{lang}BAN_FOR{/lang}</label></td>
		<td>
			<input type="text" name="ban" id="ban-for" value="1" maxlength="2" size="4" />
			<select name="timeend"><option value="60">{lang}MINUTES{/lang}</option><option value="3600">{lang}HOURS{/lang}</option><option value="86400">{lang}DAYS{/lang}</option><option value="604800">{lang}WEEKS{/lang}</option><option value="2678400">{lang}MONTHS{/lang}</option><option value="31536000">{lang}YEARS{/lang}</option></select>
		</td>
	</tr>
	<tr>
		<td><label for="reason">{lang}REASON{/lang}</label></td>
		<td>
			<input type="text" name="reason" id="reason" maxlength="{config}MAX_INPUT_LENGTH{/config}" /><br />
			<input type="checkbox" name="b_umode" id="b_umode" value="1" /><label for="b_umode">{lang}VACATION_MODE{/lang}</label>
		</td>
	</tr>
	<tr>
		<td class="center" colspan="2"><input type="submit" name="proceedban" value="{lang}BAN{/lang}" class="button" /></td>
	</tr>
	{if[{var}eBans{/var} > 0]}<tr>
		<th colspan="2">{lang}EXISTING_BANS{/lang}</th>
	</tr>
	<tr>
		<td colspan="2">
			{foreach[bans]}<div>
				{loop}reason{/loop} - {loop}to{/loop} - {loop}annul{/loop}
			</div>{/foreach}
		</td>
	</tr>{/if}
</table>
</form>