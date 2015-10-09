SimpleCov.configure do
  start("rails") do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter
    ]

    add_group "Long files" do |src_file|
      src_file.lines.count > 100
    end

    add_filter "spec/*"
  end
end
