# Capstone-Project-NLP

This project explores data science in the area of natural language processing.    

## Data
The project uses files named LOCALE.blogs.txt where LOCALE is the each of the four locales en_US, de_DE, ru_RU and fi_FI. The data is from a corpus called HC Corpora (www.corpora.heliohost.org).   
  
The corpora are collected from publicly available sources by a web crawler. The crawler checks for language, so as to mainly get texts consisting of the desired language. Each entry is tagged with it's date of publication. Where user comments are included they will be tagged with the date of the main entry. Each entry is tagged with the type of entry, based on the type of website it is collected from (e.g. newspaper or personal blog). If possible, each entry is tagged with one or more subjects based on the title or keywords of the entry (e.g. if the entry comes from the sports section of a newspaper it will be tagged with "sports" subject). In many cases it's not feasible to tag the entries or no subject is found by the automated process, in which case the entry is tagged with a '0'. To save space, the subject and type is given as a numerical code.  

Once the raw corpus has been collected, it is parsed further, to remove duplicate entries and split into individual lines. Approximately 50% of each entry is then deleted. Since you cannot fully recreate any entries, the entries are anonymised and this is a non-profit venture that would fall under Fair Use.

## 
