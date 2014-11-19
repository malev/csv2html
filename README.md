# CSV to HTML (cli)

## Just run:

    $ gem install csv2html
    $ csv2html data.csv > table.html

You can customize the table's id, table's classes, header's classes and field's classes. You can also use linux pipes and it's only one small file long with **NO** dependencies.

## Some options:

    Usage: csvtohtml.rb data.csv [options]
        -i, --table-id TABLEID           Table's ID
        -c, --table-class TABLECLASS     Table's class
        -d, --td-class class1,class2     Field's classes
            --th-class class1,class2     Header's classes

## Contributing

1. Fork it ( https://github.com/[my-github-username]/csv2html/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
