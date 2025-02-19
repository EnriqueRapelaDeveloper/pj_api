class BaseService
  def self.execute(*args, **kwargs, &block)
    new(*args, **kwargs, &block).execute
  end

  def execute
    service_execute
  end

  def service_execute
    raise NotImplementedError, 'Subclasses must implement the service_execute method'
  end
end
