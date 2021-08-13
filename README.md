# Numerical-Analysis-Google-Pagerank-Algorithm

This project was done as a part of our Maths Course on Probability-Statistics and Numerical Methods. The following [paper](https://en.wikipedia.org/wiki/PageRank) was analysed.
The PageRank algorithm is one of the most common algorithms used by search engines like Google to rank web pages on search results. Each search on the search engine results in multiple web pages that are relevant. The aim of the algorithm is to rank this given set of pages. The algorithm ranks these pages based on several parameters, the most significant ones being the number and quality of the links to it. Given the list of all links referenced by the set of pages, we determine the rank for a given page based on the number of links referenced to it and their quality.

The model showing page rank of diffrerent web pages

<img src=https://user-images.githubusercontent.com/68186100/129362909-2dd229e0-a1da-42de-bd3e-52f60fc7ee69.png width="250" height="250">

The rank of the pages is determined by formulating a set of linear equations based on the above mentioned parameters. This linear system results in an **eigen value problem** which can be solved using an **iterative approach**.

In this project, we understoodd the importance of various parameters that influence the rank of a web page. Further, we would formulated the governing equations and analyzed the numerical method that is being adopted to solve the eigen value problem. 

Some results obtained

Sample Graph of 6 webpages |  Final rank Vector
:-------------------------:|:-------------------------:
<img src=https://user-images.githubusercontent.com/68186100/129362583-a1a0200e-d691-4cb1-a61f-d53f0c4695d2.png> |<img src=https://user-images.githubusercontent.com/68186100/129362697-43c16c03-d230-4c81-a92a-c103ad9512eb.png >



In the end we also determined the **average execution time** and **number of iterations** needed to rank set of web pages of different sizes. The analysis is done for graphs of size 4-100 nodes.

Result of performance analysis.

<img src=https://user-images.githubusercontent.com/68186100/129362229-cb1c1519-3d8f-4522-9b29-61da9a7cb600.png>

# Conclusions

The time required to rank 100 pages is in the order of 10−4 seconds and execution time is of the order 10<sup>−3</sup>s when the number of pages is of the order 10<sup>3</sup>.

Due to its linear time complexity, the power iteration method can rank millions of web pages in a matter of seconds using the PageRank algorithm, making it highly effective for search engines.



# Acknowledgement

The MATLAB codes and documentation were done by all four team members Aadesh Desai, Eshan Gujarathi, Hiral Sharma and Sanjay Venkitesh. We would like to thank Prof. Dilip Srinivas Sundaram (Assistant Professor, IIT Gandhinagar), Prof. Satyajit Pramanik (Assistant Professor, IIT Gandhinagar), and Prof. Sanjay Bora for helping us with the course and providing us with all the assistance needed.
