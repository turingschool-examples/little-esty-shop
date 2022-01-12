require 'rails_helper'
require 'webmock'
require 'httparty'
RSpec.describe 'the merchants dashboard page' do

  before(:each) do
    @repo_response = '{"id":444196424,"node_id":"R_kgDOGnnmSA","name":"little-esty-shop","full_name":"croixk/little-esty-shop","private":false,"owner":{"login":"croixk","id":20864043,"node_id":"MDQ6VXNlcjIwODY0MDQz","avatar_url":"https://avatars.githubusercontent.com/u/20864043?v=4","gravatar_id":"","url":"https://api.github.com/users/croixk","html_url":"https://github.com/croixk","followers_url":"https://api.github.com/users/croixk/followers","following_url":"https://api.github.com/users/croixk/following{/other_user}","gists_url":"https://api.github.com/users/croixk/gists{/gist_id}","starred_url":"https://api.github.com/users/croixk/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/croixk/subscriptions","organizations_url":"https://api.github.com/users/croixk/orgs","repos_url":"https://api.github.com/users/croixk/repos","events_url":"https://api.github.com/users/croixk/events{/privacy}","received_events_url":"https://api.github.com/users/croixk/received_events","type":"User","site_admin":false},"html_url":"https://github.com/croixk/little-esty-shop","description":null,"fork":true,"url":"https://api.github.com/repos/croixk/little-esty-shop","forks_url":"https://api.github.com/repos/croixk/little-esty-shop/forks","keys_url":"https://api.github.com/repos/croixk/little-esty-shop/keys{/key_id}","collaborators_url":"https://api.github.com/repos/croixk/little-esty-shop/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/croixk/little-esty-shop/teams","hooks_url":"https://api.github.com/repos/croixk/little-esty-shop/hooks","issue_events_url":"https://api.github.com/repos/croixk/little-esty-shop/issues/events{/number}","events_url":"https://api.github.com/repos/croixk/little-esty-shop/events","assignees_url":"https://api.github.com/repos/croixk/little-esty-shop/assignees{/user}","branches_url":"https://api.github.com/repos/croixk/little-esty-shop/branches{/branch}","tags_url":"https://api.github.com/repos/croixk/little-esty-shop/tags","blobs_url":"https://api.github.com/repos/croixk/little-esty-shop/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/croixk/little-esty-shop/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/croixk/little-esty-shop/git/refs{/sha}","trees_url":"https://api.github.com/repos/croixk/little-esty-shop/git/trees{/sha}","statuses_url":"https://api.github.com/repos/croixk/little-esty-shop/statuses/{sha}","languages_url":"https://api.github.com/repos/croixk/little-esty-shop/languages","stargazers_url":"https://api.github.com/repos/croixk/little-esty-shop/stargazers","contributors_url":"https://api.github.com/repos/croixk/little-esty-shop/contributors","subscribers_url":"https://api.github.com/repos/croixk/little-esty-shop/subscribers","subscription_url":"https://api.github.com/repos/croixk/little-esty-shop/subscription","commits_url":"https://api.github.com/repos/croixk/little-esty-shop/commits{/sha}","git_commits_url":"https://api.github.com/repos/croixk/little-esty-shop/git/commits{/sha}","comments_url":"https://api.github.com/repos/croixk/little-esty-shop/comments{/number}","issue_comment_url":"https://api.github.com/repos/croixk/little-esty-shop/issues/comments{/number}","contents_url":"https://api.github.com/repos/croixk/little-esty-shop/contents/{+path}","compare_url":"https://api.github.com/repos/croixk/little-esty-shop/compare/{base}...{head}","merges_url":"https://api.github.com/repos/croixk/little-esty-shop/merges","archive_url":"https://api.github.com/repos/croixk/little-esty-shop/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/croixk/little-esty-shop/downloads","issues_url":"https://api.github.com/repos/croixk/little-esty-shop/issues{/number}","pulls_url":"https://api.github.com/repos/croixk/little-esty-shop/pulls{/number}","milestones_url":"https://api.github.com/repos/croixk/little-esty-shop/milestones{/number}","notifications_url":"https://api.github.com/repos/croixk/little-esty-shop/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/croixk/little-esty-shop/labels{/name}","releases_url":"https://api.github.com/repos/croixk/little-esty-shop/releases{/id}","deployments_url":"https://api.github.com/repos/croixk/little-esty-shop/deployments","created_at":"2022-01-03T20:52:32Z","updated_at":"2022-01-08T23:47:16Z","pushed_at":"2022-01-12T07:20:15Z","git_url":"git://github.com/croixk/little-esty-shop.git","ssh_url":"git@github.com:croixk/little-esty-shop.git","clone_url":"https://github.com/croixk/little-esty-shop.git","svn_url":"https://github.com/croixk/little-esty-shop","homepage":null,"size":1302,"stargazers_count":0,"watchers_count":0,"language":"Ruby","has_issues":true,"has_projects":true,"has_downloads":true,"has_wiki":true,"has_pages":false,"forks_count":0,"mirror_url":null,"archived":false,"disabled":false,"open_issues_count":40,"license":null,"allow_forking":true,"is_template":false,"topics":[],"visibility":"public","forks":0,"open_issues":40,"watchers":0,"default_branch":"main","temp_clone_token":null,"parent":{"id":313663245,"node_id":"MDEwOlJlcG9zaXRvcnkzMTM2NjMyNDU=","name":"little-esty-shop","full_name":"turingschool-examples/little-esty-shop","private":false,"owner":{"login":"turingschool-examples","id":8518346,"node_id":"MDEyOk9yZ2FuaXphdGlvbjg1MTgzNDY=","avatar_url":"https://avatars.githubusercontent.com/u/8518346?v=4","gravatar_id":"","url":"https://api.github.com/users/turingschool-examples","html_url":"https://github.com/turingschool-examples","followers_url":"https://api.github.com/users/turingschool-examples/followers","following_url":"https://api.github.com/users/turingschool-examples/following{/other_user}","gists_url":"https://api.github.com/users/turingschool-examples/gists{/gist_id}","starred_url":"https://api.github.com/users/turingschool-examples/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/turingschool-examples/subscriptions","organizations_url":"https://api.github.com/users/turingschool-examples/orgs","repos_url":"https://api.github.com/users/turingschool-examples/repos","events_url":"https://api.github.com/users/turingschool-examples/events{/privacy}","received_events_url":"https://api.github.com/users/turingschool-examples/received_events","type":"Organization","site_admin":false},"html_url":"https://github.com/turingschool-examples/little-esty-shop","description":null,"fork":false,"url":"https://api.github.com/repos/turingschool-examples/little-esty-shop","forks_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/forks","keys_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/keys{/key_id}","collaborators_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/teams","hooks_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/hooks","issue_events_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/issues/events{/number}","events_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/events","assignees_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/assignees{/user}","branches_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/branches{/branch}","tags_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/tags","blobs_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/refs{/sha}","trees_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/trees{/sha}","statuses_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/statuses/{sha}","languages_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/languages","stargazers_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/stargazers","contributors_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/contributors","subscribers_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/subscribers","subscription_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/subscription","commits_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/commits{/sha}","git_commits_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/commits{/sha}","comments_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/comments{/number}","issue_comment_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/issues/comments{/number}","contents_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/contents/{+path}","compare_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/compare/{base}...{head}","merges_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/merges","archive_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/downloads","issues_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/issues{/number}","pulls_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/pulls{/number}","milestones_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/milestones{/number}","notifications_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/labels{/name}","releases_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/releases{/id}","deployments_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/deployments","created_at":"2020-11-17T15:33:36Z","updated_at":"2021-07-30T16:07:23Z","pushed_at":"2022-01-12T04:09:40Z","git_url":"git://github.com/turingschool-examples/little-esty-shop.git","ssh_url":"git@github.com:turingschool-examples/little-esty-shop.git","clone_url":"https://github.com/turingschool-examples/little-esty-shop.git","svn_url":"https://github.com/turingschool-examples/little-esty-shop","homepage":null,"size":1073,"stargazers_count":0,"watchers_count":0,"language":"Ruby","has_issues":true,"has_projects":true,"has_downloads":true,"has_wiki":true,"has_pages":false,"forks_count":166,"mirror_url":null,"archived":false,"disabled":false,"open_issues_count":66,"license":null,"allow_forking":true,"is_template":false,"topics":[],"visibility":"public","forks":166,"open_issues":66,"watchers":0,"default_branch":"main"},"source":{"id":313663245,"node_id":"MDEwOlJlcG9zaXRvcnkzMTM2NjMyNDU=","name":"little-esty-shop","full_name":"turingschool-examples/little-esty-shop","private":false,"owner":{"login":"turingschool-examples","id":8518346,"node_id":"MDEyOk9yZ2FuaXphdGlvbjg1MTgzNDY=","avatar_url":"https://avatars.githubusercontent.com/u/8518346?v=4","gravatar_id":"","url":"https://api.github.com/users/turingschool-examples","html_url":"https://github.com/turingschool-examples","followers_url":"https://api.github.com/users/turingschool-examples/followers","following_url":"https://api.github.com/users/turingschool-examples/following{/other_user}","gists_url":"https://api.github.com/users/turingschool-examples/gists{/gist_id}","starred_url":"https://api.github.com/users/turingschool-examples/starred{/owner}{/repo}","subscriptions_url":"https://api.github.com/users/turingschool-examples/subscriptions","organizations_url":"https://api.github.com/users/turingschool-examples/orgs","repos_url":"https://api.github.com/users/turingschool-examples/repos","events_url":"https://api.github.com/users/turingschool-examples/events{/privacy}","received_events_url":"https://api.github.com/users/turingschool-examples/received_events","type":"Organization","site_admin":false},"html_url":"https://github.com/turingschool-examples/little-esty-shop","description":null,"fork":false,"url":"https://api.github.com/repos/turingschool-examples/little-esty-shop","forks_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/forks","keys_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/keys{/key_id}","collaborators_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/collaborators{/collaborator}","teams_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/teams","hooks_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/hooks","issue_events_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/issues/events{/number}","events_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/events","assignees_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/assignees{/user}","branches_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/branches{/branch}","tags_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/tags","blobs_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/blobs{/sha}","git_tags_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/tags{/sha}","git_refs_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/refs{/sha}","trees_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/trees{/sha}","statuses_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/statuses/{sha}","languages_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/languages","stargazers_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/stargazers","contributors_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/contributors","subscribers_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/subscribers","subscription_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/subscription","commits_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/commits{/sha}","git_commits_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/git/commits{/sha}","comments_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/comments{/number}","issue_comment_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/issues/comments{/number}","contents_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/contents/{+path}","compare_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/compare/{base}...{head}","merges_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/merges","archive_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/{archive_format}{/ref}","downloads_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/downloads","issues_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/issues{/number}","pulls_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/pulls{/number}","milestones_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/milestones{/number}","notifications_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/notifications{?since,all,participating}","labels_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/labels{/name}","releases_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/releases{/id}","deployments_url":"https://api.github.com/repos/turingschool-examples/little-esty-shop/deployments","created_at":"2020-11-17T15:33:36Z","updated_at":"2021-07-30T16:07:23Z","pushed_at":"2022-01-12T04:09:40Z","git_url":"git://github.com/turingschool-examples/little-esty-shop.git","ssh_url":"git@github.com:turingschool-examples/little-esty-shop.git","clone_url":"https://github.com/turingschool-examples/little-esty-shop.git","svn_url":"https://github.com/turingschool-examples/little-esty-shop","homepage":null,"size":1073,"stargazers_count":0,"watchers_count":0,"language":"Ruby","has_issues":true,"has_projects":true,"has_downloads":true,"has_wiki":true,"has_pages":false,"forks_count":166,"mirror_url":null,"archived":false,"disabled":false,"open_issues_count":66,"license":null,"allow_forking":true,"is_template":false,"topics":[],"visibility":"public","forks":166,"open_issues":66,"watchers":0,"default_branch":"main"},"network_count":166,"subscribers_count":0}'
  end



  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50)}
  let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50)}


  let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}
  let!(:customer_2) {Customer.create!(first_name: 'Dave', last_name: 'King')}
  let!(:customer_3) {Customer.create!(first_name: 'Reid', last_name: 'Anderson')}
  let!(:customer_4) {Customer.create!(first_name: 'Elvind', last_name: 'Opsvik')}
  let!(:customer_5) {Customer.create!(first_name: 'Ethan', last_name: 'Iverson')}
  let!(:customer_6) {Customer.create!(first_name: 'Chris', last_name: 'Speed')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}
  let!(:invoice_2) {customer_2.invoices.create!(status: 'completed' )}
  let!(:invoice_3) {customer_3.invoices.create!(status: 'completed' )}
  let!(:invoice_4) {customer_4.invoices.create!(status: 'completed' )}
  let!(:invoice_5) {customer_5.invoices.create!(status: 'completed' )}
  let!(:invoice_6) {customer_6.invoices.create!(status: 'completed' )}

  #Billy
  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Dave, Reid, Elvind
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_2_) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Ethan
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_9) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_10) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_11) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}

  #Chris
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 100, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_7) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}

  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 100, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}


  it "shows the name of the merchant" do

    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content(merchant_1.name)
  end

  it "links to merchant items index" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_link('My Items')
    click_link 'My Items'
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
  end

  it "links to the merchant invoices index" do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_link('My Invoices')
    # click_link 'My Invoices'
    # expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
    # need to build this later, for merchant invoices index
  end

  it "shows the names of top 5 customers" do
    visit "/merchants/#{merchant_1.id}/dashboard"

    within("#top5") do
      expect("Name: #{customer_5.first_name}, Succesful Transactions: #{customer_5.transactions.length}")
      .to appear_before("Name: #{customer_1.first_name}, Succesful Transactions: #{customer_1.transactions.length}")

      expect("Name: #{customer_1.first_name}, Succesful Transactions: #{customer_1.transactions.length}")
      .to appear_before("Name: #{customer_2.first_name}, Succesful Transactions: #{customer_2.transactions.length}")

      expect("Name: #{customer_2.first_name}, Succesful Transactions: #{customer_2.transactions.length}")
      .to appear_before("Name: #{customer_3.first_name}, Succesful Transactions: #{customer_3.transactions.length}")

      expect("Name: #{customer_3.first_name}, Succesful Transactions: #{customer_3.transactions.length}")
      .to appear_before("Name: #{customer_4.first_name}, Succesful Transactions: #{customer_4.transactions.length}")
    end
  end

  it 'displays items not yet shipped' do
    visit "/merchants/#{merchant_1.id}/dashboard"
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(item_3.name)
    expect(page).to_not have_content(item_1.name)
  end

  it "displays the date of items not yet shipped by most recent created first" do
    visit "/merchants/#{merchant_1.id}/dashboard"

    expect(item_6.name).to appear_before(item_5.name)
    expect(item_5.name).to appear_before(item_4.name)
    expect(item_4.name).to appear_before(item_3.name)
    expect(item_3.name).to appear_before(item_2.name)
  end

  end


   # the body of the test would go here...

