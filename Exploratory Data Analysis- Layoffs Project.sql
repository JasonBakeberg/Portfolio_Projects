select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select * 
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 2 desc;

select company, sum(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select substring(`date`, 1, 7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by `month` asc;

with Rolling_Total as 
(
select substring(`date`, 1, 7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by `month` asc
)
select `month`, total_off, sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

with Company_Year (Company, Years, Total_Laid_Off) as 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
),
Company_Year_Rank as 
(
select *, 
dense_rank() over (partition by Years order by Total_Laid_Off desc) as Ranking
from Company_Year
where Years is not null
)
select *
from Company_Year_Rank
where Ranking <= 5;

with Industry_Total (Industry, Total_Laid_Off) as
(
select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
),
Industry_Rank as 
(
select Industry, Total_Laid_Off,
rank() over (order by Total_Laid_Off desc) as Ranking
from Industry_Total
)
select * 
from Industry_Rank
where Industry is not null;

select company, stage, round(avg(percentage_laid_off), 2) as Percentage_Laid_Off
from layoffs_staging2
where percentage_laid_off < 1
group by company, stage
order by 3 desc;














