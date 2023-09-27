
select * from CovidDeaths
where continent is Not Null 
Order by 1,2


select location , date, total_cases, new_cases, total_deaths, population 
from CovidDeaths 
order by 1,2

--Looking at total cases vs total deaths 
--SHOWS CHANCES OF DYING IF ONE GETS COVID IN GIVEN COUNTRY
select location , date, total_cases, total_deaths,(total_deaths /total_cases)*100 as DeathPercentage
from CovidDeaths
WHERE LOCATION LIKE '%STATES%'
order by 1,2

--LOOKING AT TOTAL CASES VS POPULATION
--SHOWS WHAT % OF POPULATION GOT COVID

select location , date, population, total_cases,(total_cases / population)*100 as PercentOfPopulationInfected
from CovidDeaths
WHERE LOCATION LIKE '%STATES%'
order by 1,2

-- LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATES COMPARED TO POPULATION

select location , population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases / population)) *100 as PercentOfPopulationInfected
from CovidDeaths
group by location, Population
order by PercentOfPopulationInfected desc

--Showing countries with highest death count per population

select location ,MAX(cast(total_deaths as int)) AS TotalDeathCount
from CovidDeaths
where continent is Not Null 
group by location
order by TotalDeathCount desc

-- Breaking down by continent 

select location ,MAX(cast(total_deaths as int)) AS TotalDeathCount
from CovidDeaths
where continent is Null 
group by location
order by TotalDeathCount desc


-- Showing the continent with the highest death count
select continent ,MAX(cast(total_deaths as int)) AS TotalDeathCount
from CovidDeaths
where continent is not Null 
group by continent
order by TotalDeathCount desc

--Global numbers

select  sum(new_cases)as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int)) / sum(new_cases) *100 as DeathPercentage
from CovidDeaths
WHERE continent is not Null 
order by 1,2


-- Looking at total populaton vs vaccinations

--Use CTE

With PopVsVac (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVac)
as 
(
select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))
over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVac
from CovidDeaths dea
join CovidVaccination vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not Null 
--order by 2, 3
)
Select *, (RollingPeopleVac / Population) *100
From PopVsVac

-- Temp Tables 

Drop Table if exists #PercentPopVacc

Create Table #PercentPopVacc
(
continent nvarchar (255),
location nvarchar(255),
date datetime,
Population numeric,
new_vacc numeric,
RollingPeopleVac numeric
)

Insert into #PercentPopVacc

select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))
over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVac
from CovidDeaths dea
join CovidVaccination vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not Null 
--order by 2, 3

Select *, (RollingPeopleVac / Population) *100
From #PercentPopVacc

-- Creating View to store data for later visualizations

create view PercentPopVacc as 
select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))
over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVac
from CovidDeaths dea
join CovidVaccination vac
on dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not Null 
