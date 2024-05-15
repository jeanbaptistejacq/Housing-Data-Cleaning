/*

Cleaning Data in SQL Queries

*/

------------------------------------------------------------------------------------------------------------
			-- converting column SaleDate into standard date format
------------------------------------------------------------------------------------------------------------
SELECT saledate
FROM PortofolioProject.dbo.NashvilleHousing
WHERE ISDATE(saledate) = 0

UPDATE PortofolioProject.dbo.NashvilleHousing
SET saledate = NULL
WHERE saledate = ''

UPDATE PortofolioProject.dbo.NashvilleHousing
SET saledate = NULL
WHERE saledate LIKE '________-_______'

UPDATE PortofolioProject.dbo.NashvilleHousing
SET saledate = CONVERT(varchar, CONVERT(date, saledate, 103), 23)
WHERE saledate IS NOT NULL

SELECT saledate
FROM PortofolioProject.dbo.NashvilleHousing

------------------------------------------------------------------------------------------------------------
			--Property address data
------------------------------------------------------------------------------------------------------------

select	a.parcelID 
		,a.propertyaddress
		,b.parcelID
		,b.propertyaddress 
FROM PortofolioProject.dbo.NashvilleHousing a	
join PortofolioProject.dbo.NashvilleHousing b
	on a.parcelID = b.ParcelID
	and a.uniqueID <> b.uniqueID
where a.propertyaddress =''                    -- we need to replace '' by null value

UPDATE PortofolioProject.dbo.NashvilleHousing
SET propertyaddress = NULL
WHERE propertyaddress = ''

--self join to get PropertyAddress of the house having same parcelID

select a.parcelID, a.propertyaddress, b.parcelID, b.propertyaddress 
FROM PortofolioProject.dbo.NashvilleHousing a	
join PortofolioProject.dbo.NashvilleHousing b
	on a.parcelID = b.ParcelID
	and a.uniqueID <> b.uniqueID
where a.propertyaddress is null

update a
set propertyaddress  = isnull(a.propertyaddress,b.propertyaddress)
FROM PortofolioProject.dbo.NashvilleHousing a	
join PortofolioProject.dbo.NashvilleHousing b
	on a.parcelID = b.ParcelID
	and a.uniqueID <> b.uniqueID
where a.propertyaddress is null

------------------------------------------------------------------------------------------------------------
-- Transforming address in a proper format(Address, city, state)
------------------------------------------------------------------------------------------------------------

SELECT propertyaddress
FROM PortofolioProject.dbo.NashvilleHousing

select
substring(propertyaddress, 1, CHARINDEX('.', propertyaddress)) as Adress,
substring(propertyaddress, CHARINDEX('.', propertyaddress) + 1, len(propertyaddress )) as City

FROM PortofolioProject.dbo.NashvilleHousing

select
substring(propertyaddress, 1, CHARINDEX('.', propertyaddress)-1) as Adress

FROM PortofolioProject.dbo.NashvilleHousing


SELECT 
    CASE 
        WHEN CHARINDEX('.', propertyaddress) > 0 
            THEN SUBSTRING(propertyaddress, 1, CHARINDEX('.', propertyaddress)-1) 
        ELSE propertyaddress 
    END as Adress
, substring(propertyaddress, CHARINDEX('.', propertyaddress) + 1, len(propertyaddress )) as City

FROM PortofolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = CASE 
        WHEN CHARINDEX('.', propertyaddress) > 0 
            THEN SUBSTRING(propertyaddress, 1, CHARINDEX('.', propertyaddress)-1) 
        ELSE propertyaddress 
    END 

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = substring(propertyaddress, CHARINDEX('.', propertyaddress) + 1, len(propertyaddress ))

SELECT *
FROM PortofolioProject.dbo.NashvilleHousing

------------------------------------------------------------------------------------------------------------
				-- Transforming owner's address
------------------------------------------------------------------------------------------------------------

Select Owneraddress
FROM PortofolioProject.dbo.NashvilleHousing

select
PARSENAME(Owneraddress,3)
, PARSENAME(Owneraddress,2)
, PARSENAME(Owneraddress,1)
FROM PortofolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Owneraddress,3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity = PARSENAME(Owneraddress,2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = PARSENAME(Owneraddress,1)

--SELECT *
--FROM PortofolioProject.dbo.NashvilleHousing

------------------------------------------------------------------------------------------------------------
				-- Transforming SoldAsVacant Column as Y/N for Yes/No
------------------------------------------------------------------------------------------------------------

Select Soldasvacant
, case	when Soldasvacant = 'Y' then 'Yes'
		when Soldasvacant = 'N' then 'No'
		else Soldasvacant
		end
FROM PortofolioProject.dbo.NashvilleHousing

Update NashvilleHousing
Set Soldasvacant = case	when Soldasvacant = 'Y' then 'Yes'
		when Soldasvacant = 'N' then 'No'
		else Soldasvacant
		end

------------------------------------------------------------------------------------------------------------
				------ Removing duplicates-----
------------------------------------------------------------------------------------------------------------

WITH RowNumCTE AS (
select *
, ROW_NUMBER() over (
		partition by ParcelID,
					PropertyAddress,
					SalePrice,
					Saledate,
					LegalReference
					Order by 
						UniqueID) row_num

from PortofolioProject.dbo.NashvilleHousing
)

Delete
from RowNumCTE
where row_num > 1
--order by propertyaddress

------------------------------------------------------------------------------------------------------------
				--DELETE unused columns
------------------------------------------------------------------------------------------------------------

select *
from PortofolioProject.dbo.NashvilleHousing

alter table PortofolioProject.dbo.NashvilleHousing
drop column owneraddress, taxdistrict, propertyaddress
