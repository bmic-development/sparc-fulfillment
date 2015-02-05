$("#flashes_container").html("<%= escape_javascript(render(:partial =>'application/flash')) %>")
<% if @delete %>
change_arm()
$("#visits_select_for_<%= @arm.id %>").replaceWith( "<%= escape_javascript(build_visits_select(@arm, @current_page)) %>")
<% if  on_current_page?(@current_page, @visit_group) %>
  # Overwrite the visit_groups
$(".visit_groups_for_<%= @arm.id %>").html("<%= escape_javascript(render partial: '/service_calendar/visit_groups', locals: {arm: @arm, visit_groups: @visit_groups}) %>")
# Overwrite the check columns
$(".check_columns_for_arm_<%= @arm.id %>").html("<%= escape_javascript(render partial: '/service_calendar/check_visit_columns', locals: {visit_groups: @visit_groups}) %>")
# Overwrite the visits
<% @arm.line_items.each do |line_item| %>
$(".visits_for_line_item_<%= line_item.id %>").html("<%= escape_javascript(render partial: '/service_calendar/visits', locals: {line_item: line_item, page: @current_page, tab: @calendar_tab}) %>")
<% end %>
<% end %>
<% end %>
