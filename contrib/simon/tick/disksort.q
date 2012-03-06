/ Can't rely on xasc to perform sorting on disk efficiently (as of April 2009)
/ dis[`:2009.09.09/trade;`sym`time]
/ dip[`:2009.09.09/quote;`sym]

diu:{[t;c] / disk index `u#
	if[not`u~attr(t:hsym t)c;@[t;c;`u#]];t}
dig:{[t;c] / disk index `g#
	if[not`g~attr(t:hsym t)c;@[t;c;`g#]];t}
dip:{[t;c] / disk index `p#
	if[not`p~attr(t:hsym t)c;@[t;c;`p#]];t}

disA:{[t;c;a] / disk index, sorted, apply `s# or `p# at end depending on granularity 
	if[not`s~attr(t:hsym t)c;
		if[count value` sv t,first value` sv t,`.d;
			ii:iasc iasc flip c!t c,:();
			if[not$[(0,-1+count ii)~(first;last)@\:ii;@[{`s#x;1b};ii;0b];0b];
				{v:get y;if[not$[all(fv:first v)~/:256#v;all fv~/:v;0b];v[x]:v;y set v];}[ii]each` sv't,'get` sv t,`.d]];
		@[t;first c;a]];t}
dis:disA[;;`s#]
disp:disA[;;`p#]

/ oneliner of above to build into csvguess.q 	
disksort:{[t;c;a]if[not`s~attr(t:hsym t)c;ii:iasc iasc flip c!t c,:();if[not$[(0,-1+count ii)~(first;last)@\:ii;@[{`s#x;1b};ii;0b];0b];{v:get y;if[not$[all(fv:first v)~/:256#v;all fv~/:v;0b];v[x]:v;y set v];}[ii]each` sv't,'get` sv t,`.d];@[t;first c;a]];t}

dip2:{[t;c] / disk index `p# and fall back to sort if need be
	if[`s~atc:attr(t:hsym t)c;@[t;c;`p#];:t];
	if[not`p~atc;
		if[@[{@[x;y;`p#];0b}t;c;1b];
			if[count value` sv t,first value` sv t,`.d;
				ii:iasc iasc flip c!t c,:();
				if[not$[(0,-1+count ii)~(first;last)@\:ii;@[{`s#x;1b};ii;0b];0b];
					{v:get y;if[not$[all(fv:first v)~/:256#v;all fv~/:v;0b];v[x]:v;y set v];}[ii]each` sv't,'get` sv t,`.d]];
		@[t;first c;`p#]]];t}
