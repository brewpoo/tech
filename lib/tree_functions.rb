module TreeFunctions

  def full_name(sep=' / ')
    here=self
    label=here.name
    while here.parent
      here=here.parent
      label=here.name+sep+label
    end
    return label
  end

  def depth
    here=self
    depth=0
    while here.parent
      depth+=1
      here=here.parent
    end
    depth
  end

  def fqdn
    here=self
    label=here.name
     while here.parent
       here=here.parent
       label=label+'.'+here.name
     end
     return label
  end

  def tree_select_map(list,indent)
    output = []
    margin = ""
    indent.times { margin += "--" }
    list.each { |item| 
      output.push [margin+item.name, item.id]
      if !item.children.empty?
        output.push tree_select_map(item.children,indent+1)
      end
    }
    return output
  end

  def ancestors
    a=[]
    a << self
    while a.parent
      a << a.ancestors
    end
    return a
  end

  def descendants
    d=[]
    d << self
    self.children.each do |child|
      d << child.descendants
    end
    return d
  end

  def descendant_ids
    d=[]
    d << self.id
    self.children.each do |child|
      d << child.descendant_ids
    end
    return d
  end


end
