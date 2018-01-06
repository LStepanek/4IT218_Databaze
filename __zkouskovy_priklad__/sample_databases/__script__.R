###############################################################################
###############################################################################
###############################################################################

## instaluji a loaduji balíčky ------------------------------------------------

invisible(
    lapply(
        c(
            "xtable"
        ),
        function(my_package){
            
            if(!(my_package %in% rownames(installed.packages()))){
                
                install.packages(
                    my_package,
                    dependencies = TRUE,
                    repos = "http://cran.us.r-project.org"
                )
                
            }
            
            library(my_package, character.only = TRUE)
            
        }
    )
)


## ----------------------------------------------------------------------------

###############################################################################

## nastavuji pracovní složku --------------------------------------------------

while(!"__script__.R" %in% dir()){
    setwd(choose.dir())
}

mother_working_directory <- getwd()


## ----------------------------------------------------------------------------

###############################################################################

## nahrávám všechna .csv v mateřské složce ------------------------------------

for(my_filename in dir()[grepl("\\.csv$", dir())]){
    
    assign(
        gsub(
            "\\.csv$",
            "",
            my_filename
        ),
        read.table(
            file = my_filename,
            header = TRUE,
            sep = ";",
            colClasses = "character",
            encoding = "UTF-8"
        )
    )
    
}


###############################################################################

## pro každou databázi vytvářím soubor s daným SQL příkazem a ukládám ho ------

for(
    my_database_name in
    gsub("\\.csv$", "", dir()[grepl("\\.csv$", dir())])
){
    
    my_database <- get(my_database_name)
    my_output <- NULL
    
    for(i in 1:dim(my_database)[1]){
        
        my_output <- c(
            my_output,
            paste(
                "INSERT INTO ",
                my_database_name,
                " VALUES ('",
                paste(
                    unname(unlist(my_database[i, ])),
                    collapse = "', '"
                ),
                "');",
                sep = ""
            )
        )
        
    }
    
    writeLines(
        con = paste(
            my_database_name,
            "_insert.txt",
            sep = ""
        ),
        text = my_output
    )
    
}


## ----------------------------------------------------------------------------

###############################################################################

## vytvářím TeXový výstup v konzoli R pro každou relační tabulku --------------

for(
    my_database_name in
    gsub("\\.csv$", "", dir()[grepl("\\.csv$", dir())])
){
    
    my_database <- get(my_database_name)
    
    print(
        xtable(
            my_database,
            align = rep("", ncol(my_database) + 1),
            digits = 0
        ),
        floating = FALSE,
        tabular.environment = "tabular",
        hline.after = NULL,
        include.rownames = FALSE,
        include.colnames = TRUE,
        format.args = list(decimal.mark = ",")
	)
    
}






## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





