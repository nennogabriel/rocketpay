defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all paramaters are valid, return an user" do
      params = %{
        name: "Pedro",
        password: "123456",
        nickname: "nennogabriel",
        email: "pedro@seal.works",
        age: "38"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Pedro", age: 38, id: ^user_id} = user
    end

    test "when there are invalid paramaters, return an user" do
      params = %{
        name: "Pedro",
        nickname: "nennogabriel",
        email: "pedro@seal.works",
        age: "38"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{password: ["can't be blank"]}
      assert errors_on(changeset) == expected_response
    end
  end
end
