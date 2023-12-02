public CBGR48 gr_palette_oxocarbon[COLORS_NUM]={
	0xffff7e7eb6b6, // pink
	0xbebe9595ffff, // purple
	0xffffffffffff, // white
	0x8282cfcfffff, // cyan
	0xeeee53539696, // red
	0x8282cfcfffff, // cyan
	0x525252525252, // dark gray
	0x393939393939, // light gray
	0x262626262626, // light black
	0x3333b1b1ffff, // blue
	0x4242bebe6565, // green
	0x3d3ddbdbd9d9, // cyan
	0xeeee53539696, // light red
	0xbebe9595ffff, // purple
	0xffffffffffff, // "green"
	0x161616161616, // black (background)
};

GrPaletteSet(gr_palette_oxocarbon);
MemCpy(gr_palette_std, gr_palette_oxocarbon, sizeof(gr_palette_oxocarbon));
