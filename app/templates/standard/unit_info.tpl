<table class="ntable">
	<tr>
		<th colspan="2">{@name}</th>
	</tr>
	<tr>
		<td colspan="2">
			{@pic}{@description}
			{if[count($this->loopStack["rapidfire"]) > 0]}
			<br class="clear" /><br />
			<div>
				<strong>{lang}RAPIDFIRE{/lang}</strong><br />
				{foreach[rapidfire]}
				{loop}rapidfire{/loop}: {loop}value{/loop}<br />
				{/foreach}
			</div>{/if}
			{perm[CAN_EDIT_CONSTRUCTIONS]}<div class="right">{@edit}</div>{/perm}
		</td>
	</tr>
	<tr>
		<td width="35%">{lang}STRUCTURE{/lang}</td>
		<td>{@structure}</td>
	</tr>
	<tr>
		<td>{lang}SHIELD{/lang}</td>
		<td>{@shield}</td>
	</tr>
	<tr>
		<td>{lang}ATTACK{/lang}</td>
		<td>{@attack}</td>
	</tr>
	<tr>
		<td>{lang}SHELL{/lang}</td>
		<td>{@shell}</td>
	</tr>
	{if[$this->templateVars["mode"] == 3]}
	<tr>
		<td>{lang}CAPACITY{/lang}</td>
		<td>{@capacity}</td>
	</tr>
	<tr>
		<td>{lang}BASIC_SPEED{/lang}</td>
		<td>{@speed}</td>
	</tr>
	<tr>
		<td>{lang}CONSUMPTION{/lang}</td>
		<td>{@consume}</td>
	</tr>
	<tr>
		<td>{lang=ENGINE}</td>
		<td>
			{foreach[engines]}
			<?php if($row["level"] == 0): ?>
			{loop=name}<br/>
			<?php else: ?>
			{lang=FROM_LEVEL_I} {loop=level}: {loop=name}
			<?php if($row["base_speed"] > 0): ?>({lang}BASIC_SPEED{/lang}: {loop=base_speed})<?php endif ?>
			<?php endif ?>
			{/foreach}
		</td>
	</tr>
	{/if}
</table>