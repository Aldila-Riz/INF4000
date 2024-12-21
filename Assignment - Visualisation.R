

#----------------------Line Chart Trend by Cost Category-----------
cost_long %>% 
  ggplot(aes(x = Year, y = value, colour = cost, group = cost)) +
  geom_point(alpha=0.5,size = 3) +  # Larger points for better visibility
  geom_line(size = 1) +   # Thicker lines
  facet_wrap(~cost, scales = "free_y") +  # Free y-scales for each facet
  theme_bw() +  # Black-and-white theme
  labs(
    title = "Trends Over Years by Cost Category",  # Add a title
    subtitle = "Visualizing the yearly trends for each cost category",
    x = "Year",
    y = "Number of Incidents",
    colour = "Cost Category",
    caption = "Data Source: Office for National Statistics (ONS), Nature of Crime: Bicycle Theft Dataset."
  ) +
  scale_colour_viridis_d()+
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),  # Centered and bold title
    plot.subtitle = element_text(hjust = 0.5, size = 14),  # Centered subtitle
    plot.caption = element_text(size = 10, face = "italic", hjust = 1),  # Caption aligned to the right
    axis.title.x = element_text(size = 14, face = "bold"),  # Larger x-axis label
    axis.title.y = element_text(size = 14, face = "bold"),  # Larger y-axis label
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1),  # Rotate x-axis text
    axis.text.y = element_text(size = 12),  # Larger y-axis text
    legend.position = "bottom",  # Move legend to the bottom
    legend.title = element_text(size = 12, face = "bold"),  # Bold legend title
    legend.text = element_text(size = 11),  # Larger legend text
    panel.spacing = unit(1, "lines")  # Increase spacing between facets
  )


#--------------------Pie Chart by location----------------



#pie chart 
library(ggplot2)
library(RColorBrewer)
install.packages("paletteer")
library(paletteer)

ggplot(where_summary, aes(x = "", y = total_value, fill = where)) +
  geom_bar(stat = "identity", width = 1, color = "white") +  # Add white border for clarity
  coord_polar(theta = "y") + 
  theme_void() +  # Minimal theme for clean visuals
  #scale_fill_brewer(palette = "Set2") +  # Switch to Set2 for softer, colorblind-friendly palette
  scale_fill_paletteer_d("rcartocolor::Antique")+
  geom_text(aes(label = paste0(round(percentage, 1), "%")), 
            position = position_stack(vjust = 0.5), 
            size = 3,  # Adjust label size for readability
            color = "white", 
            fontface = "bold",
            angle=45) +  # Bold labels for emphasis
  labs(
    title = "Distribution of Bicycle Thefts in the UK by Location\n from 2012 to 2022",
    subtitle = "Visualizing the percentage distribution of theft attempts by location",
    fill = "Theft Location",
    caption = "Data Source: Office for National Statistics (ONS), Nature of Crime: Bicycle Theft Dataset"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  # Center and enlarge title
    plot.subtitle = element_text(hjust = 0.5, size = 12),  # Center subtitle
    plot.caption = element_text(size = 10, hjust = 0, face = "italic"),  # Left-align caption
    legend.position = "right",  # Place legend on the right for clarity
    legend.title = element_text(size = 12, face = "bold"),  # Style legend title
    legend.text = element_text(size = 10)  # Adjust legend text size
  )

#-----------------------------Grouped Bar Chart--------------------------------
time_long_data %>% 
  filter(!time%in% c("Evening/night (unsure which)",
                     "Morning/afternoon (unsure which)",
                     "During the week",
                     "At the weekend")) %>% 
  ggplot(aes(Year, y = value, fill = time)) +
  geom_bar(stat = "identity", position = position_dodge()) +  # Use "identity" to plot actual values
  labs(
    title = "Grouped Bar Chart: Time vs Year",
    x = "Year",
    y = "Value",
    fill = "Time Classification",
    caption = "Bicycle Thefts in the UK (2012-2022), Collected from Office for National Statistic"
  ) +
  theme_minimal() +
  scale_fill_viridis_d()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#------------------------------Heatmap Vis-------------------------------


time_long %>%
  filter(!time%in% c("Evening/night (unsure which)",
                     "Morning/afternoon (unsure which)")) %>% #filter out from the plot
  ggplot(aes(x = Year, y = time, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "blue", high = "red", name = "Value") +
  labs(title = "Heatmap of Time vs Year",
       x = "Year",
       y = "Time Classification",
       caption = "Bicycle Thefts in the UK (2012-2022), Collected from Office for National Statistics") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1,
                                   size = 11,
                                   face = "bold"),
        axis.text.y = element_text(size = 11,
                                   face ="bold"))+
  scale_fill_viridis(option = "D", name="Value") #account for colour blind audience
