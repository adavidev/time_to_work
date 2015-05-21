class TextFile

  def initialize(filePath)
    @filePath = filePath
  end

  def read()
    result = Array.new
    File.open(@filePath, "r").each_line do |textLine|
      arr = textLine.split(" ")
      projects = arr.select { |words| words[0] == "+" }
      arr.reject! { |words| words[0] == "+" }
      context = arr.select { |words| words[0] == "@" }
      arr.reject! { |words| words[0] == "@" }
      due = arr.select { |words| words.start_with?('due:')  }
      arr.reject! { |words| words.start_with?('due:')  }
      result << { "text" => arr.join(" "), "projects" => projects, "context" => context, "due" => due[0][4..-1] }
    end
    result
  end

  def write(data)
    File.open(@filePath, 'w') { |file|
      data.each do |textLine|
        line = textLine["text"]
        line += " "
        line += textLine["projects"].join(" ")
        line += " "
        line += textLine["context"].join(" ")
        line += " due:"
        line += textLine["due"]
        file.puts(line)
      end
    }
  end

end