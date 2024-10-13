{ ... }: {
  programs.bottom = {
    enable = true;
    settings.flags = {
      avg_cpu = true;
      battery = true;
      colors = { low_battery_color = "red"; };
      enable_gpu_memory = true;
      hide_table_gap = false;
      hide_time = true;
      rate = "1s";
      temperature_type = "c";
    };
  };
}
