def app
    GetTo24Controller
end

describe GetTo24Controller, :type => :controller do
  describe 'get /' do
    it 'renders the home page' do
      get '/'

      expect(last_response).to be_ok
    end
  end

  describe 'get /about' do
    it 'renders the about page' do
      get '/about'

      expect(last_response).to be_ok
    end
  end

  describe 'get /problem' do
    it 'renders a new problem' do
      get '/problem'

      expect(last_response).to be_ok
      expect(last_response.body).to match(/^\s*<div class="numbers">(\d\s){3}\d\<\/div>$/)
    end

    it 'generates a new problem every time' do
      get '/problem'
      first_problem = problem_markup = /^\s*<div class="numbers">(\d\s){3}\d\<\/div>$/.match(last_response.body).to_s
      get '/problem'
      second_problem = problem_markup = /^\s*<div class="numbers">(\d\s){3}\d\<\/div>$/.match(last_response.body).to_s

      expect(first_problem).to_not eq(second_problem)
    end
  end

  describe 'post /check' do
    let(:problem_string) { "6 6 6 6" }

    it "renders 'correct' view if solution equals 24" do
      get '/problem'

      solution = "6+6+6+6"
      post '/check', {"problem"=>problem_string, "solution"=>solution}

      expect(last_response).to be_ok
      expect(last_response.body).to include("#{solution} = 24!")
    end

    xit "renders 'incorrect' view if solution does not match problem" do
      solution = "(1+2+3)*(4)"
      post '/check', {"problem"=>problem_string, "solution"=>solution}

      expect(last_response).to be_ok
      expect(last_response.body).to include("#{solution} = 24!")
    end

    it "renders 'incorrect' view if solution does not equal 24" do
      solution = "6/6+6*6"
      post '/check', {"problem"=>problem_string, "solution"=>solution}

      expect(last_response).to be_ok
      expect(last_response.body).to include("Sorry, that's not right.")
    end

    it 'displays error if solution input is invalid' do
      post '/check', {"problem"=>problem_string, "solution"=>'invalid'}

      expect(last_response).to be_ok
      expect(last_response.body).to include("= ???")
      expect(last_response.body).to include("Sorry, that's not right.")
    end
  end

  describe 'get /solve' do
    it 'renders input form for problem to sovle' do
      get '/solve'

      expect(last_response.body).to match(/<input type="text" name="problem" class="inputbox" autofocus="autofocus">/)
    end
  end

  describe 'post /solution' do
    it 'displays message if problem cannot be solved' do
      post '/solution', { "problem" => "1 1 1 1" }

      expect(last_response).to be_ok
      expect(last_response.body).to include("No solution found!")
    end

    it 'displays solution when it exists' do
      post '/solution', { "problem" => "6 6 6 6" }

      expect(last_response).to be_ok
      expect(last_response.body).to include("6 + 6 + 6 + 6 = 24!")
    end

    it 'supports a comma-separated list' do
      post '/solution', { "problem" => "6, 6, 6, 6" }

      expect(last_response).to be_ok
      expect(last_response.body).to include("6 + 6 + 6 + 6 = 24!")
    end

    it 'displays error if problem input is invalid' do
      post '/solution', {"problem" => 'invalid'}

      expect(last_response).to be_ok
      expect(last_response.body).to include("Invalid input, please try again")
    end
  end
end
