module SuperDuperConfig
  extend self

  def self.extended(base)
    base.reset!
  end

  def reset!
    @configuration = Hashie::Mash.new
  end

  def from_file!(file)
    if File.file?(file)
      YAML.load(ERB.new(File.new(file).read).result)[Rails.env].each do |k,v|
        configuration[k] = v
      end
    end
  end

  def configure(*args, &block)
    options = args.extract_options!
    options.key?(:reset) && options[:reset] && reset!
    options.key?(:from_file) && options[:from_file] && from_file!(options[:from_file])

    instance_eval &block if block_given?
  end

  def configuration
    @configuration ||= Hashie::Mash.new
  end

  def method_missing(method, *args)
    if !(method.to_s =~ /(.+)=$/).nil?
      configuration[$1] = args[0]
    elsif configuration.respond_to?(method)
      configuration.send method, *args
    elsif configuration.key?(method)
      configuration[method]
    elsif args.size === 1
      configuration[method] = args[0]
    end
  end

end