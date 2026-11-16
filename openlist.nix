# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  # 1. 安装 openlist 软件包
  environment.systemPackages = [
    pkgs.openlist
  ];

  # 2. 为 openlist 创建 systemd 常驻服务
  systemd.services.openlist = {
    description = "OpenList Daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      # 执行 openlist 的启动命令，指定运行模式为 server
      ExecStart = "${pkgs.openlist}/bin/OpenList server";
      # 声明状态目录，systemd 会自动创建 /var/lib/openlist
      StateDirectory = "openlist";
      # 指定数据存储目录（可自定义，确保该目录存在或由服务自动管理）
      WorkingDirectory = "/var/lib/openlist";
      Restart = "on-failure";
      User = "root"; # 如果需要更安全，可以单独为其创建 openlist 用户
    };
  };

  # 3. 如果开启了防火墙，需要放行默认的 5244 端口
  # networking.firewall.allowedTCPPorts = [ 5244 ];
}
