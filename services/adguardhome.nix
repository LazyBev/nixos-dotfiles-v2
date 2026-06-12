{ ... }: {
  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    settings = {
      schema_version = 19;
      dns = {
        bind_host = "0.0.0.0";
        port = 53;
        upstream_dns = [
          "tls://dns.nextdns.io"
          "https://dns.nextdns.io/dns-query"
        ];
        bootstrap_dns = [ "45.90.28.0:53" "45.90.30.0:53" ];
        filtering_enabled = true;
        filters_update_interval = 48;
        edns_client_subnet = {
          enabled = false;
        };
        block_services = [];
        parental_enabled = false;
        safesearch_enabled = true;
        safebrowsing_enabled = true;
        querylog_interval = 720;
      };
      filtering = {
        filtering_enabled = true;
        filters = [
          {
            enabled = true;
            url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
            name = "AdGuard DNS filter";
          }
          {
            enabled = true;
            url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
            name = "StevenBlack's Unified Hosts";
          }
        ];
      };
      tls = {
        enabled = false;
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 3000 ];
  };
}
