{ ... }: {
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
  };
}
