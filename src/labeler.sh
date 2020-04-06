#!/usr/bin/env bash

labeler::label() {
  local -r fail_if_xl="$5"

  local -r pr_number=$(github_actions::get_pr_number)
  local -r total_modifications=$(github::calculate_total_modifications "$pr_number")

  log::message "Total modifications: $total_modifications"

  local -r label_to_add=$(labeler::label_for "$total_modifications" "$@")

  log::message "Labeling pull request with $label_to_add"

  github::add_label_to_pr "$pr_number" "$label_to_add"

  if [ "$label_to_add" == "size/xl" ] && [ "$fail_if_xl" == "true" ]; then
    echoerr "Pr is xl, please, short this!!"
    exit 1
  fi
}

labeler::label_for() {
  local -r total_modifications="$1"
  local -r xs_max_size="$2"
  local -r s_max_size="$3"
  local -r m_max_size="$4"
  local -r l_max_size="$5"

  if [ "$total_modifications" -lt "$xs_max_size" ]; then
    label="super_easy"
  elif [ "$total_modifications" -lt "$s_max_size" ]; then
    label="easy"
  elif [ "$total_modifications" -lt "$m_max_size" ]; then
    label="bearable"
  else
    label="mind_blowing"
  fi

  echo "$label"
}
