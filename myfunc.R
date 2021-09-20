# ggplot-related functions

init_plt <- theme_bw() +
  theme(axis.text=element_text(size=10, color="black"),
        panel.grid = element_blank(),
        panel.border = element_rect(size = 1)
  )

plt_pred <- function(g){
  out <- g +
    init_plt +
    scale_x_continuous(breaks = seq(0,1,length=2)) +
    coord_cartesian(xlim = c(-0.5, 1.5), ylim = c(-1, 9)) +
    geom_point(position = position_jitter(width = 0.05, seed = 8232),
               shape = 16, alpha = 0.2, color = "#333333") +
    xlab("AU1") + ylab("Amusement") +
    geom_ribbon(data = pred, aes(ymin = Lower, ymax = Upper), fill = "#DDDDDD", alpha = 0.5) +
    geom_line(data = pred)
  
  return(out)
}

plt_est <- function(g){
  out <- g +
    init_plt +
    scale_x_continuous(breaks = seq(-3,3,1)) +
    scale_y_continuous(breaks = seq(-3,3,1)) +
    coord_cartesian(xlim = c(-3, 3), ylim = c(-3, 3)) +
    geom_errorbar(aes(ymin = beta1_Lower, ymax = beta1_Upper), alpha = 0.5, width = 0, color = "#888888") +
    geom_errorbarh(aes(xmin = beta0_Lower, xmax = beta0_Upper), alpha = 0.5, height = 0, color = "#888888") +
    geom_point(shape = 16, alpha = 0.8, color = "#333333") +
    xlab("beta0") + ylab("beta1")
}
