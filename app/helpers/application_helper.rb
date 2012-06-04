module ApplicationHelper
  def is_active(*args)
    if args.size == 1
      "active" if params[:action] == args.first
    elsif args.size == 2
      "active" if params[:controller] == args.first && params[:action] == args.last
    end
  end
end
