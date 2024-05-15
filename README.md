# Housing Data Cleaning
![large_15gAQdddPzO5Cn18bJ-4zQTUHrfpVxWQbAQ6jhvTSc](https://github.com/jeanbaptistejacq/Housing-Data-Cleaning/assets/80902643/50105cf1-76f8-4e23-bf69-244d25cae4d0)
We are using a comprehensive dataset of housing properties. The aim is to prepare the dataset for further analysis. The dataset includes attributes such as the owner's address, property address, owner's name, sale date, sale price, total rooms, and more.

## Content

[1. Getting Started](#getting-started)  
&emsp;[1.1 Requirements](#requirements)  
[2. Download and Installation](#download-and-installation)  
[3. Data Source](#data-source)  
[4. Data Cleaning Process](#data-cleaning-process)  
[5. License](#license)  

## Getting Started

The following instructions will help you get a copy of this project and execute the queries to observe the result sets they generate.

### Requirements

You need to have any DBMS (Database Management System) installed on your system that supports the standard SQL syntax and functions, such as MySQL, PostgreSQL, Microsoft SQL Server **(the one I used)**, Oracle, or others.

## Download and Installation

1. You can clone this repository or simply download the .zip file by clicking on 'Code' -> 'Download ZIP' at <https://github.com/jeanbaptistejacq/Housing-Data-Cleaning>.

2. Once you have all the files of this project, you can find the dataset in different tables in excel files in the 'tables' folder. They need to be imported into a new database or an existing one so the queries can be executed against them.

3. Open your SQL DB Manager, create a new database or use an existing one to import the excel files into tables. The steps may vary depending on the DB manager you are using. Here is a general approach: In your DB manager, locate the option to import data from a file or external source ->
Select the Excel files one by one and follow the prompts to specify the target table and mapping of columns ->
Verify that the data has been imported successfully by checking the table contents.

4. The queries I wrote for this project can be found in the 'queries' folder. You can open the file directly to run them or create new query windows to copy/paste them into the editor.  

5. Execute the query you want to retrieve the desired results.  

**Note:** Please ensure you have a valid database connection established in your DB manager before executing the queries. Adjust the queries if needed based on the structure of the imported tables.

## Data Source

The original dataset is stored in an Excel file called HousingData.csv. This file is located in the 'tables' folder.

## Data Cleaning Process

1. Converting the SaleDate into Standard Date Format: SQL's date manipulation functions are used. This step ensures consistency in date representation for accurate analysis.

2. Explore property address Data: Involves examining address-related attributes to identify patterns, inconsistencies, or missing values that might require cleaning and standardization. Also separating address into individual columns such as Address, City, State.

3. Self-Join for PropertyAddress: We will perform a self-join operation on the dataset to retrieve the property address of houses sharing the same parcelID. This step allows us to gain insights into properties with multiple units or structures.

4. Transforming Owner's Address: Similar to the property address, we will also work on transforming and standardizing the owner's address data. This ensures uniformity and accuracy in the owner's address information.

6. Removing Duplicates: Duplicate entries can skew analysis results. We will identify and remove duplicate rows from the dataset based on unique identifiers such as parcelID or owner's name. This step guarantees that each record represents a unique property or transaction.

7. Deleting Unused Columns: We will identify and delete columns that are not contributing to the analysis. This action simplifies the dataset structure while improving query performance.

</br>

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details.
