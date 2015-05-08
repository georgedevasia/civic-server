ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: 'Dashboard'

  content title: 'CIViC Administrator Dashboard' do
     columns do

       column do
         panel "Recent Activity" do
           ul do
             Event.includes(:originating_user, :subject).order('created_at DESC').limit(10).map { |e| EventPresenter.new(e) }.map do |e|
               li "#{e.description} (#{time_ago_in_words(e.timestamp)})"
             end
           end
         end
       end
       column do
         panel "Recently Joined Users" do
           ul do
             User.order('users.created_at DESC').limit(10).map do |u|
               li link_to("#{u.display_name} (#{time_ago_in_words(u.created_at)} ago)", admin_user_path(u))
             end
           end
         end
       end
     end
  end
end
