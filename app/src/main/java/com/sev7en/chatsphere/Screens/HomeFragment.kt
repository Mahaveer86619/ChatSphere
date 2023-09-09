package com.sev7en.chatsphere.Screens

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.sev7en.chatsphere.Adapters.UserDataModel
import com.sev7en.chatsphere.Adapters.UserRecyclerViewAdapter
import com.sev7en.chatsphere.R

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [HomeFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class HomeFragment : Fragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null




    // variables of the fragment
    private lateinit var recyclerview: RecyclerView
    private lateinit var userList: ArrayList<UserDataModel>





    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_home, container, false)
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment HomeFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            HomeFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }





    // Code of the Fragment
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // for demo purpose
        dataInitilize()

        recyclerview = view.findViewById(R.id.recyclerview)
        recyclerview.layoutManager = LinearLayoutManager(context)
        val adapter = UserRecyclerViewAdapter(userList)
        recyclerview.adapter = adapter


    }

    // Demo arraylist for testing before calling from firebase
    private fun dataInitilize () {

        userList = ArrayList<UserDataModel>()

        userList.add(UserDataModel(R.drawable.default_person, "person1", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person2", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person3", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person4", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person5", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person6", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person7", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person8", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person9", "hello", "00:00"))
        userList.add(UserDataModel(R.drawable.default_person, "person10", "hello", "00:00"))
    }
}