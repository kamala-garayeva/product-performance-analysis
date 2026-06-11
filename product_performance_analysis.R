# Product Performance Analysis: Top vs Bottom Sellers
# Author: Kamala Garayeva
# Description: Identifies best and worst performing products by revenue
#              to support inventory and merchandising decisions.

library(dplyr)
library(ggplot2)

# Load data
df <- read.csv("product_performance.csv")

# Sort by revenue
df_sorted <- df %>% arrange(desc(revenue))

# Top 5 and Bottom 5 products
top5 <- head(df_sorted, 5)
bottom5 <- tail(df_sorted, 5)

# Combine for plotting
top5$group <- "Top 5"
bottom5$group <- "Bottom 5"
combined <- rbind(top5, bottom5)
combined$product <- factor(combined$product, levels = combined$product[order(combined$revenue)])

# Plot
ggplot(combined, aes(x = product, y = revenue, fill = group)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = c("Top 5" = "#2ecc71", "Bottom 5" = "#e74c3c")) +
  labs(
    title = "Product Performance Analysis: Top vs Bottom Sellers",
    x = "Product",
    y = "Revenue ($)",
    fill = "Category"
  ) +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(face = "bold", size = 14))

ggsave("product_performance.png", width = 10, height = 6, dpi = 150)

# Summary statistics
cat("\n--- Summary ---\n")
cat("Total Revenue:", sum(df$revenue), "\n")
cat("Average Revenue per Product:", round(mean(df$revenue), 2), "\n")
cat("\nTop Performer:", top5$product[1], "- Revenue:", top5$revenue[1], "\n")
cat("Lowest Performer:", bottom5$product[5], "- Revenue:", bottom5$revenue[5], "\n")

# Business insight
cat("\n--- Business Recommendation ---\n")
cat("Consider discontinuing or repositioning bottom-performing products,\n")
cat("and expanding shelf space / marketing for top performers.\n")
