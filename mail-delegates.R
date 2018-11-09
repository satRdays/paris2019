library(gmailr)

# addresses = read.csv("2017-delegates.csv", header = FALSE, stringsAsFactors = FALSE)[,1]
# addresses = read.csv("2017-workshop-attendees.csv", header = FALSE, stringsAsFactors = FALSE)[,1]
addresses = read.csv("test-addresses.csv", header = FALSE, stringsAsFactors = FALSE)[,1]

# mime() %>%
#   from("satrday.cape.town@gmail.com") %>%
#   subject("satRday: Workshop Preparation") %>%
#   text_body('Hi!
#             
# Get yourself prepared for two days of intense R learning. To make sure that everything runs smoothly, please get these installed and tested BEFORE you arrive:
#             
# 1. R and RStudio;
# 2. Git.
# 
# There are a few more important steps for the "Git with R" workshop. Find those here: https://tinyurl.com/jgljhqy.
#             
# Also install some critical R packages:
# 
# install.packages(c("shiny",
#                    "flexdashboard",
#                    "dplyr",
#                    "ggplot2",
#                    "leaflet",
#                    "devtools"))
# 
# devtools::install_github("juliasilge/southafricastats")
# 
# Please note: it is vital that you set up your system in advance. You cannot show up at with no preparation and keep up!
# 
# Best regards,
# Andrew.') -> text_msg

mime() %>%
  from("satrday.cape.town@gmail.com") %>%
  subject("satRday: Select your Tutorial") %>%
  text_body("Hi!

We're looking forward to meeting you and around 200 other R enthusiasts in Cape Town on Saturday 18 February.

Take a look at the technical programme to see what's in store for you (https://capetown2017.satrdays.org/#programme).

Most of the day will be a single stream of talks. However, we kick off with a choice of three tutorials (these will happen in parallel, so you need to choose one!). In order for us to allocate seating for those tutorials, please let us know which one you'd prefer to attend.

Your choices are:

1. Image processing and Tensorflow in R (Raymond Ellis and Greg Streatfield)

2. Redis + R = Multi-user R apps (David Lubinsky)

3. Shiny / R and Devops (Marko Jakovljevic)

Just reply with your selection. Choose carefully!

Best regards,
Andrew.") -> text_msg

# mime() %>%
#   from("satrday.cape.town@gmail.com") %>%
#   subject("satRday: Visualisation Challenge") %>%
#   text_body("Hi,
# 
# Just over a week to go before satRday Cape Town!
# 
# We wanted to send out a reminder about the Visualisation Challenge (https://capetown2017.satrdays.org/#visualisation): stand a chance to win a Tableau license valued at R27 000.
# 
# Don't miss the submission deadline on 14 February!
#               
# Best regards,
# Andrew.") -> text_msg

# strwrap(as.character(text_msg))

httr::set_config(httr::config(ssl_verifypeer = 0L))

for (to in addresses) {
  print(to)
  text_msg$header$To = to
  send_message(text_msg)
}
