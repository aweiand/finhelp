require 'test_helper'

class ExtracaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extracao = extracaos(:one)
  end

  test "should get index" do
    get extracaos_url
    assert_response :success
  end

  test "should get new" do
    get new_extracao_url
    assert_response :success
  end

  test "should create extracao" do
    assert_difference('Extracao.count') do
      post extracaos_url, params: { extracao: { s: @extracao.s } }
    end

    assert_redirected_to extracao_url(Extracao.last)
  end

  test "should show extracao" do
    get extracao_url(@extracao)
    assert_response :success
  end

  test "should get edit" do
    get edit_extracao_url(@extracao)
    assert_response :success
  end

  test "should update extracao" do
    patch extracao_url(@extracao), params: { extracao: { s: @extracao.s } }
    assert_redirected_to extracao_url(@extracao)
  end

  test "should destroy extracao" do
    assert_difference('Extracao.count', -1) do
      delete extracao_url(@extracao)
    end

    assert_redirected_to extracaos_url
  end
end
