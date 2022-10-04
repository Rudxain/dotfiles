/*
these are intended to be copy-pasted.
`abs` & `sign` are generic, to support `BigInt`s
*/
const
	{log: print, clear: cls} = console,
	abs = x => x < 0 ? -x : x,
	sign = x => x == 0 ? x : x / abs(x)
