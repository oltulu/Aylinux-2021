cd live
for dir in BasicUsageEnvironment groupsock liveMedia UsageEnvironment; do
install -Dm 644 ${dir}/*.a -t "${PKG}/usr/lib"
install -Dm 644 ${dir}/include/*.h* -t "${PKG}/usr/include/${dir}"
done
find testProgs -type f -perm 755 -print0|xargs -0 -I '{}' install -Dm 755 '{}' -t "${PKG}/usr/bin"
