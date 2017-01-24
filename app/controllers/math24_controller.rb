class Math24Controller < ApplicationController
  get '/' do
    erb :'math24/index'
  end

  get '/about' do
    erb :'math24/about'
  end

  get '/problem' do
    problem = Math24.generate_problem.join(" ")
    erb :'math24/problem', :locals => {:problem => problem}
  end

  get '/solve' do
    erb :'math24/solve', :locals => {:invalid => false}
  end

  post '/solution' do
    problem = "#{params[:problem] || ""}"
    if problem.include?(",")
      numbers = problem.delete(" ").split(",")
    else
      numbers = problem.squeeze(" ").split
    end

    valid = numbers.all? do |number|
      number.to_i > 0 && number.to_i < 10
    end

    if valid
      solution = Math24.solve(numbers)
      message = solution ? "#{solution} = 24" : "No solution found"
      erb :'math24/solution', :locals => {:problem => numbers.join(" "),
                                 :message => message,
                                 :last_answer => 24}
    else
      erb :'math24/solve', :locals => {:invalid => true}
    end
  end

  post '/check' do
    problem = "#{params[:problem] || ""}"
    solution = "#{params[:solution] || ""}"
    numbers = problem.split

    begin
      valid_solution = Math24.check(numbers, solution)
    rescue ArgumentError
      error = true
      valid_solution = false
    end

    if valid_solution
      erb :'math24/correct',
          :locals => {
            :problem => problem,
            :solution => solution
          }
    elsif error
      erb :'math24/incorrect', :locals => {:problem => problem,
                                  :solution => solution,
                                  :last_answer => '???'}
    else
      erb :'math24/incorrect', :locals => {:problem => problem,
                                  :solution => solution,
                                  :last_answer => instance_eval(solution)}
    end
  end
end
