#library("palmerpenguins")

#head(penguins, 5)
#ggplot(data=penguins)+ #+はレイヤーを追加するために付けなければならない。
#  geom_point(mapping=aes(x=flipper_length_mm,y=body_mass_g)) #geometric object used to present your data #the way a variable looks is called aesthetic #set mapping value to define the mapping between your data and your plot #Mapping: matching up a specific variable in your dataset widh a specific aesthetic
# ggplot2の基本的な使い方
# 1. start with the ggplot function and choose a dataset to work with
# 2. add a geom_function to display your data
# 3. map the variables you want to plot in the argument of the aes function.
# ※ "?geom_point"でヘルプガイドを出せる。