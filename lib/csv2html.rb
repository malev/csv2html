# encoding: UTF-8

require "csv"
require "erb"
require "optparse"
require "csv2html/version"


module CSV2HTML
  class Conversor
    attr_reader :headers, :options, :rows

    def initialize(data, options)
      parser = CSV.parse(data, headers: true)
      @headers = parser.headers
      @options = options
      @rows = parser
    end

    def get_binding
      binding
    end

    def tag(name, opts={})
      output = [name]
      output << "class=\"#{opts[:class]}\"" if opts.has_key?(:class)
      output << "id=\"#{opts[:id]}\"" if opts.has_key?(:id)
      "<" + output.join(' ') + ">"
    end

    def row_class(options, index)
      classes = options[:row_class]
      if classes.nil? || classes[index].nil?
        ''
      else
        " class=\"#{classes[index]}\""
      end
    end

    def header_class(options, index)
      classes = options[:header_class]
      if classes.nil? || classes[index].nil?
        ''
      else
        " class=\"#{classes[index]}\""
      end
    end
  end

  class Application
    def initialize(argv)
      @options, @file = parse_options(argv)
    end

    def run
      csv_to_html = if @file.empty?
        Conversor.new(STDIN.read, @options)
      else
        Conversor.new(File.read(ARGV[0]), @options)
      end
      print ERB.new(DATA.read).result(csv_to_html.get_binding)
    end

    def parse_options(argv)
      options = {}
      parser = OptionParser.new

      parser.banner = "Usage: csvtohtml.rb data.csv [options]"

      # Optional argument; Table's ID
      parser.on("-i", "--table-id TABLEID", "Table's ID") do |v|
        options[:id] = v
      end

      # Optional argument; Table's class
      parser.on("-c", "--table-class TABLECLASS", "Table's class") do |v|
        options[:class] = v
      end

      parser.on("-d", "--td-class class1,class2", Array, "Field's classes") do |v|
        options[:row_class] = v
      end

      parser.on("--th-class class1,class2", Array, "Header's classes") do |v|
        options[:header_class] = v
      end

      files = parser.parse(argv)
      [options, files]
    end
  end
end

begin
  CSV2HTML::Application.new(ARGV).run
rescue Errno::ENOENT => err
  abort "csvtohtml: #{err.message}"
rescue OptionParser::InvalidOption => err
  abort "csvtohtml: #{err.message}\nusage: csvtohtml.rb data.csv [options]"
end

__END__
<%= tag('table', options) %>
  <thead><% headers.each_with_index do |header, index| %>
    <th<%= header_class(options, index) %>>
      <%= header %>
    </th><% end %>
  </thead>
  <tbody><% rows.each do |row| %>
      <tr><% row.each_with_index do |r, index| %>
        <td data-title="<%= r[0] %>"<%= row_class(options, index) %>><%= r[1] %></td><% end %>
      </tr><% end %>
  </tbody>
</table>
