# IRC Latin America — shared theme, colours, and typography
# source("theme.R") at the top of any script or qmd that produces charts.

library(showtext)
library(ggplot2)

# ── 1. Fonts ──────────────────────────────────────────────────────────────────
USE_SHOWTEXT <- tryCatch({
  font_add_google("Inter", "Inter")
  font_add_google("Roboto Mono", "Roboto Mono")
  showtext_auto()
  TRUE
}, error = function(e) {
  message("showtext: Google Fonts unavailable — falling back to system fonts.")
  FALSE
})

F_MAIN <- if (USE_SHOWTEXT) "Inter"       else "sans"
F_MONO <- if (USE_SHOWTEXT) "Roboto Mono" else "mono"

# ── 2. Brand colours ──────────────────────────────────────────────────────────
irc_yellow <- "#FFC72C"  # IRC brand highlight — featured values, totals
irc_dark   <- "#383838"  # Median / central estimate markers
irc_mid    <- "#666666"  # Non-highlighted bars, secondary elements
irc_light  <- "#D1D1D1"  # Outliers, male gender, background fills

# ── 3. Country colours ────────────────────────────────────────────────────────
# Central America: a cool blue group, NCA darkest. Pre-FY22 data uses NCA as an
# aggregate; from FY22 onward Guatemala, El Salvador and Honduras report
# separately. NCA, Guatemala and Honduras share the blue ramp to signal the same
# geographic entity; El Salvador is shifted to a distinct teal-green so it
# separates cleanly from Guatemala — the two were previously adjacent stops of
# the same blue and hard to tell apart in line charts.
#
# Other countries: standardised Atlassian subset, consistent across Latam work.
country_colours <- c(
  NCA            = "#115E78",
  Guatemala      = "#2898BD",
  `El Salvador`  = "#3FB59A",   # teal-green — distinct from Guatemala's blue
  Honduras       = "#A2D9E8",   # light — use thicker lines in line charts
  Colombia       = "#B38600",
  Ecuador        = "#22A06B",
  Mexico         = "#357DE8",
  Peru           = "#AF59E1",
  Venezuela      = "#CD519D"
)

# Geographic order, north to south (by latitude). Used to order countries in
# tables (north = top row) and stacked bars (north = top of stack / legend).
# NCA leads its constituent cluster (Guatemala / Honduras / El Salvador).
country_order_ns <- c("Mexico", "NCA", "Guatemala", "Honduras", "El Salvador",
                      "Venezuela", "Colombia", "Ecuador", "Peru")

country_flags <- c(
  NCA            = "\U0001F30E",
  Guatemala      = "\U0001F1EC\U0001F1F9",
  `El Salvador`  = "\U0001F1F8\U0001F1FB",
  Honduras       = "\U0001F1ED\U0001F1F3",
  Colombia       = "\U0001F1E8\U0001F1F4",
  Ecuador        = "\U0001F1EA\U0001F1E8",
  Mexico         = "\U0001F1F2\U0001F1FD",
  Peru           = "\U0001F1F5\U0001F1EA",
  Venezuela      = "\U0001F1FB\U0001F1EA"
)

# ── 4. Sector colours ─────────────────────────────────────────────────────────
sector_colours <- c(
  Education        = "#FF5630",
  Health           = "#6554C0",
  Power            = "#FFAB00",
  Safety           = "#36B37E",
  `Econ wellbeing` = "#00B8D9"
)

# ── 5. Outcome colours ───────────────────────────────────────────────────────
# Two hue families: warm terracotta for protection outcomes, cool slate for services/development.
outcome_colours <- c(
  CP        = "#B5451B",
  PRoL      = "#D4725A",
  WPE       = "#EBA899",
  Education = "#2E5F8A",
  Health    = "#5B8DB8",
  ERD       = "#9BC1DA"
)

# ── 6. Gender colours ─────────────────────────────────────────────────────────
gender_colours <- c(
  Total  = "#FFC72C",
  Female = "#000000",
  Male   = "#D1D1D1"
)

# ── 6. Simulation distribution colours ───────────────────────────────────────
sim_colours <- c(
  median  = "#383838",
  middle  = "#FFC72C",
  outlier = "#D1D1D1"
)

# ── 7. ggplot theme ───────────────────────────────────────────────────────────
theme_irc <- function(legend_position = "none") {
  theme_minimal(base_family = F_MAIN) %+replace%
    theme(
      axis.title.x    = element_text(size = 18, margin = margin(t = 15)),
      axis.title.y    = element_text(size = 18, margin = margin(t = 15)),
      axis.text.y     = element_text(size = 9),
      axis.text.x     = element_text(family = F_MONO, size = 9),
      legend.position = legend_position,
      legend.title    = element_blank(),
      legend.text     = element_text(size = 9)
    )
}
