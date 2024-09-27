## example of collecting lat/long points with VGS...

# Load necessary libraries
library(sf)
library(dplyr)
library(ggmap)

# Create a data frame with the coordinates
points <- data.frame(
  id = 1:3,
  lat = c(34.0522, 34.0529, 34.0525),
  lon = c(-118.2437, -118.2434, -118.2434)
)

# Convert points to an sf object
points_sf <- st_as_sf(points, coords = c("lon", "lat"), crs = 4326)

# Create a polygon from the points
polygon <- points_sf %>%
  summarise(geometry = st_combine(geometry)) %>%
  st_cast("POLYGON")

# Print the polygon
print(polygon)

st_crs(polygon)

cor_sd_t <- st_crs(polygon)

st_area(polygon)

load("token.Rds")
ggmap::register_stadiamaps(paste0(Token), write=T)

bbox <- c(left = -118.27, bottom = 34.04, right = -118.22, top = 34.06)
map <- get_stadiamap(bbox = bbox)

ggmap(map) + 
  geom_point(aes(x = lon, y = lat), data = data.frame(points))
