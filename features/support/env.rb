require "pathname"

class DirHash

  def initialize(dir)
    @dir = Pathname(dir)
  end

  def [](file)
    file_path = @dir + file
    file_path.read if file_path.exist?
  end

  def []=(file, content)
    if content.nil?
      remove(file)
    else
      write(file, content)
    end
  end

  def remove(file)
    (@dir + file).unlink
  end

  def write(file, content, options = {})
    file_path = @dir + file
    file_path.parent.mkpath
    file_path.open("w") do |io|
      io << content
    end
    if options[:mtime]
      timestamp = options[:mtime]
      file_path.utime(timestamp, timestamp)
    end
  end

end

class InternalLogger

  def initialize
    @messages = []
  end

  attr_reader :messages

  def clear
    @messages.clear
  end

  def info(message, &block)
    message ||= block.call
    write(message)
  end

  alias :warn :info
  alias :debug :info

  def write(message)
    @messages << message
  end

end

$project_dir = Pathname(__FILE__).expand_path.parent.parent.parent
$tmp_dir = $project_dir + "tmp"

$input_dir = $tmp_dir + "input"

$output_dir = $tmp_dir + "output"
$output_dir.mkpath

$: << ($project_dir + "lib").to_s
require "pith"

Before do
  [$input_dir, $output_dir].each do |dir|
    dir.rmtree if dir.exist?
    dir.mkpath
  end
  @project = Pith::Project.new($input_dir, $output_dir, :logger => InternalLogger.new)
  @inputs = DirHash.new($input_dir)
  @outputs = DirHash.new($output_dir)
end
