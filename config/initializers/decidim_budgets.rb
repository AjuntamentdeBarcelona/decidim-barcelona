# frozen_string_literal: true

require "budgets_workflow_pam2020"
require "budgets_workflow_pam2021"
Decidim::Budgets.workflows[:pam2020] = BudgetsWorkflowPam2020
Decidim::Budgets.workflows[:pam2021] = BudgetsWorkflowPam2021
