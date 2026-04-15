library(ggplot2)
library(RColorBrewer)

# --- Daten ---
layers <- data.frame(
  label = c("DATA", "MAPPING", "GEOMETRIES", "STATISTICS",
            "SCALES", "COORDINATES", "FACETS", "THEME"),
  level = 1:8,
  stringsAsFactors = FALSE
)

shrink      <- 0.09
layers$xmin <- shrink * (layers$level - 1) / 2
layers$xmax <- 1 - shrink * (layers$level - 1) / 2
layers$ymin <- (layers$level - 1) * 1.0
layers$ymax <- layers$level * 1.0 - 0.1

# --- Farben: RColorBrewer "Set2" ---
set2 <- brewer.pal(8, "Set2")
layers$fill_color <- setNames(set2, layers$label)[layers$label]

# Dunklere Randfarbe für 3D-Effekt
darken <- function(hex, f = 0.65) {
  v <- col2rgb(hex) / 255 * f
  rgb(v[1], v[2], v[3])
}
layers$border_color <- sapply(layers$fill_color, darken)

# Textfarbe und -font anpassen (Layer essenziell/optional)
layers$text_color <- ifelse(
  layers$level <= 3,
  "#333333", "#FFFFFF"
)
layers$font <- ifelse(layers$level <=3,
                          "bold", "italic")

# --- Plot ---
ggplot(layers) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
                fill = label),
            color     = layers$border_color,
            linewidth = 1) +
  geom_text(aes(x     = (xmin + xmax) / 2,
                y     = (ymin + ymax) / 2,
                label = label),
            color    = layers$text_color,
            fontface = layers$font,
            size     = 4.5) +
  scale_fill_manual(values = setNames(layers$fill_color, layers$label)) +
  coord_cartesian(xlim = c(-0.05, 1.05), ylim = c(-0.3, 8.3)) +
  theme_void() +
  theme(
    legend.position  = "none",
    plot.background  = element_rect(fill = "white", color = NA),
    plot.margin      = margin(0, 0, 0, 0)
  )

ggsave("images/ggplot_grammar.png", width = 10, height = 10, units = "cm")
