{
  config,
  lib,
  pkgs,
  ...
}:

{


boot.kernelParams = [
  "zswap.enabled=1"
  "zswap.compressor=zstd"
  "zswap.zpool=zsmalloc"
  "zswap.max_pool_percent=20"
];

boot.kernel.sysctl = {
  "vm.swappiness" = 100;
  "vm.page-cluster" = 0;
  "vm.watermark_scale_factor" = 125;
  "vm.max_map_count" = 1048576;
};

}
