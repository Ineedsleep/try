{include}"ranking_index"{/include}

<table class="ntable">
	<colgroup>
		<col width="30"/>
		<col width="200"/>
		<col width="60"/>
		<col width="105"/>
		<col width="105"/>
	</colgroup>
	<thead><tr>
		<th>#</th>
		<th>{lang}ALLIANCE{/lang}</th>
		<th>{lang}MEMBERS{/lang}</th>
		<th>{lang}POINTS{/lang}</th>
		<th>{lang}AVERAGE{/lang}</th>
	</tr></thead>
	<tfoot><tr>
		<td colspan="5">
			<p class="legend"><cite><span class="alliance">{lang=ALLIANCE}</span></cite>{foreach[relationTypes]}<cite><span class="{loop=css}">{loop=name}</span></cite>{/foreach}</p>
		</td>
	</tr></tfoot>
	<tbody>{foreach[ranking]}<tr>
		<td>{loop}rank{/loop}</td>
		<td>{loop}tag{/loop}</td>
		<td>{loop}members{/loop}</td>
		<td>{loop}totalpoints{/loop}</td>
		<td>{loop}average{/loop}</td>
	</tr>{/foreach}</tbody>
</table>