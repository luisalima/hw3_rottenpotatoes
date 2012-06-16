# -------------------- Background methods -------------------------#
# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie) # @LU
  end
#  flunk "Unimplemented"
end

# ---------------- methods for filter_movie_list.feature ---------------#

#When /^I check the 'PG' and 'R' checkboxes$/ do
#  check('ratings[PG]')
#  check('ratings[R]')
#end

# ^I check the (?:'([^']+)'(?:[^']+))+checkboxe[s]+$
# ('([^']+)'(?:\s+and|,\s+|\s*))+
# ^I check the (?:'([^']+)'(?:,\s+|\s+|\s+and\s+))+checkboxe[s]+$
# (?:'([^']+)'(?:,|\s))+
#When I check the '([^'])'(?:(?:,\s+|\s+and\s+)'([^'])')* checkboxe[s]?
#http://stackoverflow.com/questions/2652554/which-regex-flavors-support-captures-as-opposed-to-capturing-groups

#When /^I check the following ratings: (.+)$/ do |ratings_lst|
#  ratings_lst.gsub(/\s+/, "").split(',').each do |rating|
#    check('ratings[#{rating}]')
#  end
#end

# And I press "Refresh" goes to the
#
#When /^I press "([^"]*)"$/ do |button|
#  click_button(button)
#end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"


# #When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
#   # HINT: use String#split to split up the rating_list, then
#   #   iterate over the ratings and reuse the "When I check..." or
#   #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
   rating_list.gsub(/\s+/, "").split(',').each do |rating|
     step %Q{I #{uncheck}check "ratings_#{rating}"}
   end
end

# NOT NECESSARY BECAUSE GIVEN JUST REDUCES TO THE CASE ABOVE WITH WHEN
#Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
#  step %Q{I #{uncheck}check rating_list}
#end


Then /^I should see all of the movies$/ do
  rows_html_table = page.all('tbody#movielist tr').count
#  puts page.all('tbody#movielist tr')
#  puts Movie.count
#  puts rows_html_table
  Movie.count.should == rows_html_table
end

Then /^I should not see any movie$/ do
  page.all('tbody#movielist tr').count.should == 0
end

# ----------------- this is for sorting ---------------------------#

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  ### MAYBE... except that page.content does not exist!!!
#  puts page.body
  page.body.should =~ /.*#{e1}.*#{e2}.*/m
end
