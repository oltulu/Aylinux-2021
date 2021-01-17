_tools=( 'as10k1' 'hdsploader' 'mixartloader' 'pcxhrloader' 'sb16_csp' 'seq/sbiload'
'sscape_ctl' 'us428control usx2yloader' 'vxloader' 'ld10k1'  'hdajackretask' 'hda-verb' 'hdajacksensetest')

for tool in ${_tools[@]}; do
(
  cd $tool
  make DESTDIR="$PKG" install
)
done
