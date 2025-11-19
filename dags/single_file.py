
import datetime
from airflow.sdk import dag
from airflow.providers.tableau.operators.tableau import TableauOperator

from operators.snowflake import run_sql_hook

# 10 am UTC and 6 pm UTC
# 8 pm AEST and 2 am AEST
@dag(start_date=datetime.datetime(2021, 1, 1), schedule="0 10,18 * * *", tags=["tableau_refresh"])
def acpr_consolidated_dashboard():
    refresh_job = TableauOperator(
        # https://prod-apsoutheast-a.online.tableau.com/#/site/careabout/workbooks/2267294/views
        resource='workbooks',
        method='refresh',
        site_id='careabout',
        match_with='name',
        find='ACPR Consolidated Dashboard',
        task_id='task_refresh_acpr_consolidated_dashboard',
        tableau_conn_id='careabout_tableau',
        pool='tableau_refresh'
    )
    
    acpr_metrics = run_sql_hook("published/dashboards/acpr_metrics")
    acpr_metrics >> refresh_job

    opps_and_acpr = run_sql_hook("published/dashboards/opps_and_acpr")
    opps_and_acpr >> refresh_job
    
    coverage_by_suburb = run_sql_hook("published/dashboards/coverage_by_suburb")
    coverage_by_suburb >> refresh_job

acpr_consolidated_dashboard()